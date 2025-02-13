module fetchInstruction(clk, rst, 
						PC_In,
						branchingPCEnable_in,
						MEM_WB_Branch_in,
						dump, 
						PC_Next, 
						instruction,
						PC_WriteEn_in,
						stall);




	input [15:0] PC_In; 
	input clk, dump, rst, branchingPCEnable_in, PC_WriteEn_in, stall, MEM_WB_Branch_in; 

	output [15:0] PC_Next;
	output [15:0] instruction; 

	wire [15:0] currentPC, pc_increment, pcUpdated;

	//wires that we don't care about
	wire c_out; 

	// if we are branching or stalling halt the PC
	assign pc_increment = (stall | branchingPCEnable_in) ? 16'h0 : 16'h2;

///////////////////////////////////////////////////////////
	assign pcUpdated = (MEM_WB_Branch_in) ? PC_In : PC_Next; 

	//Inputs: clk, rst, writeEnable, [15:0] writeData
	//Output: [15:0]readData 
	register_16bits PC_Register( .readData(currentPC), .clk(clk), .rst(rst), .writeData(pcUpdated), .writeEnable(~dump)); 


	// instruction Memory
	// instruction comes from the current PC
	memory2c instructionMemory (.data_in(16'b0), .addr(currentPC),
								.enable(1'b1), .wr(1'b0), .clk(clk), .rst(rst),
								.createdump(dump), .data_out(instruction)); 

	

	// Adding 2 to the PC
	rca_16b PC_Adder(.A(currentPC), .B(pc_increment), 
					 .C_in(1'b0), .S(PC_Next), 
					 .C_out(c_out));	 
endmodule

