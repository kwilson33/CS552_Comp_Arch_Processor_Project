//Mark added this file to the project. There was 
//no skeleton code here. 
module bitreg16 (out, clk, rst, writeData, writeEn); 

output   [15:0]out;
input          clk;
input          rst;
input	 [15:0]writeData;
input 		writeEn; 

wire[15:0] in; 


dff b[15:0] (.q(out), .d(in), .clk(clk), .rst(rst)); 

assign in = writeEn ? writeData : out; 


endmodule
