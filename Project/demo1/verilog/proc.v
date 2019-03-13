/* $Author: karu $ */
/* $LastChangedDate: 2009-03-04 23:09:45 -0600 (Wed, 04 Mar 2009) $ */
/* $Rev: 45 $ */
module proc (/*AUTOARG*/
   // Outputs
   err, 
   // Inputs
   clk, rst
   );

   input clk;
   input rst;

   output err;

   // None of the above lines can be modified

   // OR all the err ouputs for every sub-module and assign it as this
   // err output
   
   // As described in the homeworks, use the err signal to trap corner
   // cases that you think are illegal in your statemachines
   
   /* your code here */


   // signals for the fetch, decode, memory, and execute
   wire [15:0] updatedPC, next_PC_normal, instruction, 
			   readData, writeData,
         // alu_B is the register we're storing into memory
         aluOutput, alu_A, alu_B;

			    
   wire enable, wr, createDump, JAL_en;

   
   /*
   * This module instantiates the instruction memory and the PC Register to keep track of the current PC
   * there is also an adder instantiated here to increment the PC
  */  
  fetchInstruction      instructionFetch(.clk(clk), .rst(rst), .PC_In(updatedPC), 
									                       .dump(createDump), .PC_Next(next_PC_normal), 
									                       .instruction(instruction));
   
  /*
   * This module instantiates the control unit and the register file. The control decides what to do 
   * with the instruction and the register file is told what to do. The control unit also makes
   * signals like SESelect which the regFile doesn't use.
   */
  decodeInstruction     instructionDecode(.clk(clk), .rst(rst), .writeData(writeData), 
									                        .instruction(instruction), .err(err));

  /*comment*/
  executeInstruction    instructionExecute(.reg7_En(JAL_en), .instr(instruction), .invA(invA),
                                           .invB(invB), .Cin(Cin), 
                                           .SESel(instructionDecode.control.SESel),
                                           .A(alu_A), .B(alu_B), .next_PC_normal(next_PC_normal), 
                                           .aluOutput(aluOutput), .updatedPC(updatedPC));

  /*comment*/
  memoryReadWrite       dataMemory (.clk(clk), .rst(rst), .writeData(alu_B),
                                    .readData(readData), 
                                    .memRead(instructionDecode.control.DMemEn), 
                                    .memWrite(instructionDecode.control.DMemWrite),
                                    .aluOutput(aluOutput), .dump(createDump));

 /*comment*/
  writebackOutput       instructionWriteback(.readData(readData), .writeData(writeData), .aluOutput(aluOutput),
                                             .PC_Next(next_PC_normal), 
                                             .memToReg(instructionDecode.control.MemToReg), 
                                             .JAL_en(JAL_en));
						
  
	 
endmodule // proc
// DUMMY LINE FOR REV CONTROL :0:
