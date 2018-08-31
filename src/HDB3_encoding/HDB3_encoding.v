module HDB3_encoding
(
	input wire clk,
	input wire rst,
	input wire origin_data,
	input wire en,
	
	output wire[2:0] encoding_data,
	output wire encoding_data_instruction
);
	
	wire[1:0] loading_V_output;
	wire[1:0] loading_B_output;
	wire encoding_data_instruction_tmp;
	
	loading_V loading_V_object
	(
		.origin_data(origin_data),
		.clk(clk),
		.rst(rst),
		.en(en),
		
		.encoding_data(loading_V_output)
	);
	
	loading_B loading_B_object
	(
		.origin_data(loading_V_output),
		.rst(rst),
		.clk(clk),
		.en(en),
		
		.encoding_data(loading_B_output),
		.encoding_data_instruction(encoding_data_instruction_tmp)
	);
	
	loading_plus_or_minus loading_plus_or_minus_object
	(
		.rst(rst),
		.clk(clk),
		.origin_data(loading_B_output),
		.en(encoding_data_instruction_tmp),
		
		.encoding_data(encoding_data),
		.encoding_data_instruction(encoding_data_instruction)
	);

endmodule