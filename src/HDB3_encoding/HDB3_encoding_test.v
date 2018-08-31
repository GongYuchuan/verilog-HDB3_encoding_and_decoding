`timescale 1ns/1ns
module HDB3_encoding_test;

	reg clk;
	reg rst;
	reg origin_data;
	reg en;
	
	wire[2:0] encoding_data;
	wire encoding_data_instruction;
	
	HDB3_encoding HDB3_encoding_object
	(
		.clk(clk),
		.rst(rst),
		.origin_data(origin_data),
		.en(en),
		
		.encoding_data(encoding_data),
		.encoding_data_instruction(encoding_data_instruction)
	);
	
	initial
	begin
		clk = 1'b0;
		#1;
		repeat(80)
		begin
			clk = 1'b1;
			#1;
			clk = 1'b0;
			#1;
		end
	end
	
	initial
	begin
		rst = 1'b1;
		en  = 1'b0;
		#2;
		rst = 1'b0;
		#6;
		rst = 1'b1;
		en  = 1'b1;
		origin_data = 1'b1;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b1;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b1;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b1;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		origin_data = 1'b0;
		#2;
		en  = 1'b0;		
	end
	
	initial
	begin
		$monitor($time,"origin_data = %d,encoding_data = %b,encoding_data_instruction = %b",
		origin_data,encoding_data,encoding_data_instruction);
	end

endmodule