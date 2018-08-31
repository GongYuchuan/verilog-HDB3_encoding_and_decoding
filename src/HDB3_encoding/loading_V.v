module loading_V
(
	input wire origin_data,
	input wire clk,
	input wire rst,
	input wire en,
	
	output reg[1:0] encoding_data
);
	
	parameter V = 2'b10;
	
	reg[1:0] count_zero;
	
	always@(posedge clk or negedge rst)
	begin
		if(~rst)
		begin
			count_zero <= 2'b0;
			encoding_data <= 2'bz;
		end
		else
		begin
			if(en)
			begin
				if(origin_data == 1'b0)
				begin
					if(count_zero == 2'd3)
					begin
						encoding_data[1] <= 1'b1;
						count_zero <= 2'b0;
					end
					else
					begin
						count_zero <= count_zero + 1'b1;
						encoding_data[1] <= 1'b0;
					end
				end
				else
				begin
					count_zero <= 1'b0;
					encoding_data[1] <= 1'b0;
				end
				encoding_data[0] <= origin_data;
			end
			else
				encoding_data <= 2'bz;
		end
	end
	
endmodule