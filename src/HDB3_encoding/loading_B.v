module loading_B
(
	input wire[1:0] origin_data,
	input wire rst,
	input wire clk,
	input wire en,
	
	output wire[1:0] encoding_data,
	output wire encoding_data_instruction
);
	
	reg[3:0] origin_data_buff_low;
	reg[3:0] origin_data_buff_high;
	reg[4:0] en_buff;
	reg statistic_start;
	reg odd_1_or_even_0;
	
	always@(negedge clk or negedge rst)
	begin
		if(~rst)
		begin
			origin_data_buff_high <= 4'b0;
			origin_data_buff_low  <= 4'b0;
			odd_1_or_even_0       <= 1'b0;
			en_buff               <= 5'b0;
			statistic_start       <= 1'b0;
		end
		else
		begin
			if(en || en_buff[4])
			begin
				en_buff[4:0] <= {en_buff[3:0],en};
				if(origin_data[1] == 1'b1)
				begin
					if(statistic_start == 1'b0)
					begin
						statistic_start <= 1'b1;
						origin_data_buff_high[3:0] <= {origin_data_buff_high[2:0],origin_data[1]};
						origin_data_buff_low[3:0]  <= {origin_data_buff_low[2:0],origin_data[0]};
					end
					else
					begin
						statistic_start <= 1'b0;
						origin_data_buff_low[2:0]  <= {origin_data_buff_low[1:0],origin_data[0]};
						origin_data_buff_high[2:0] <= {origin_data_buff_high[1:0],origin_data[0]};
						if(odd_1_or_even_0 == 0)
						begin
							origin_data_buff_high[3] <= 1'b1;
							origin_data_buff_low[3]  <= 1'b1;
						end
						else
						begin
							origin_data_buff_high[3] <= 1'b0;
							origin_data_buff_low[3]  <= 1'b0;
						end
					end
				end
				else
				begin
					origin_data_buff_high[3:0] <= {origin_data_buff_high[2:0],origin_data[1]};
					origin_data_buff_low[3:0]  <= {origin_data_buff_low[2:0],origin_data[0]};
					if(statistic_start == 1'b1 && origin_data[0] == 1'b1)
						odd_1_or_even_0 <= ~odd_1_or_even_0;
					else
						odd_1_or_even_0 <= odd_1_or_even_0;
				end
			end
			else
			begin
				en_buff <= 5'b0;
				statistic_start <= 1'b0;
				odd_1_or_even_0 <= 1'b0;
			end
		end
	end
	
	assign encoding_data[1] = origin_data_buff_high[3] & encoding_data_instruction;
	assign encoding_data[0] = origin_data_buff_low[3] & encoding_data_instruction;
	assign encoding_data_instruction = en_buff[4];
	
endmodule