module loading_plus_or_minus
(
	input wire rst,
	input wire clk,
	input wire[1:0] origin_data,
	input wire en,
	
	output wire[2:0] encoding_data,
	output wire encoding_data_instruction
);
	
	reg plus_or_minus;
	reg en_buff;
	reg[1:0] origin_data_buff;
	
	parameter V = 2'b10;
	parameter B = 2'b11;
	
	always@(posedge clk or negedge rst)
	begin
		if(~rst)
		begin
			plus_or_minus <= 1'b0;
			en_buff       <= 1'b0;
		end
		else
		begin
			en_buff <= en;
			case(origin_data)
				V:plus_or_minus <= plus_or_minus;
				B:plus_or_minus <= ~plus_or_minus;
				2'b0:plus_or_minus <= plus_or_minus;
				2'b01:plus_or_minus <= ~plus_or_minus;
				default:plus_or_minus <= plus_or_minus;
			endcase
		end
	end
	
	always@(posedge clk or negedge rst)
	begin
		if(~rst)
			origin_data_buff <= 1'b0;
		else
			origin_data_buff <= origin_data;
	end
	assign encoding_data = {plus_or_minus & (origin_data_buff[1] | origin_data_buff[0]),origin_data_buff};
	assign encoding_data_instruction = en_buff;
	
	
endmodule