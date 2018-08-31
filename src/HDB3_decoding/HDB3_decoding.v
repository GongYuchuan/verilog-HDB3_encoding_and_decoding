module HDB3_decoding
(
	input wire[2:0] encoding_data,
	input wire encoding_instruction,
	input wire rst,
	input wire clk,
	
	output reg decoding_data,
	output reg decoding_error,
	output reg decoding_instruction
);
	
	
	always@(negedge clk or negedge rst)
	begin
		if(~rst)
		begin
			decoding_data <= 1'b0;
			decoding_error <= 1'b0;
			decoding_instruction <= 1'b0;
		end
		else
		begin
			decoding_instruction <= encoding_instruction;
			if(encoding_instruction)
			begin
				case(encoding_data)
				3'b000:
				begin
					decoding_data  <= 1'b0;
					decoding_error <= 1'b0;
				end
				3'b001:
				begin
					decoding_data  <= 1'b1;
					decoding_error <= 1'b0;
				end
				3'b010:
				begin
					decoding_data  <= 1'b0;
					decoding_error <= 1'b0;
				end
				3'b011:
				begin
					decoding_data  <= 1'b0;
					decoding_error <= 1'b0;
				end
				3'b100:
				begin
					decoding_data  <= 1'b0;
					decoding_error <= 1'b0;
				end
				3'b101:
				begin
					decoding_data  <= 1'b1;
					decoding_error <= 1'b0;
				end
				3'b110:
				begin
					decoding_data  <= 1'b0;
					decoding_error <= 1'b0;
				end
				2'b111:
				begin
					decoding_data  <= 1'b0;
					decoding_error <= 1'b0;
				end
				default:
				begin
					decoding_data  <= decoding_data;
					decoding_error <= 1'b1;
				end
				endcase
			end
			else
			begin
				decoding_data <= 1'b0;
				decoding_error <= 1'b0;
			end
		end
	end
	
endmodule