//Mark added this file to the project. There was 
//no skeleton code here. 
module bitreg16 (out, clk, rst, writeData); 

output   [15:0]out;
input          clk;
input          rst;
input	 [15:0]writeData;

dff b1( out[0], writeData[0], clk, rst);
dff b2( out[1], writeData[1], clk, rst);
dff b3( out[2], writeData[2], clk, rst);
dff b4( out[3], writeData[3], clk, rst);
dff b5( out[4], writeData[4], clk, rst);
dff b6( out[5], writeData[5], clk, rst);
dff b7( out[6], writeData[6], clk, rst);
dff b8( out[7], writeData[7], clk, rst);
dff b9( out[8], writeData[8], clk, rst);
dff b10( out[9], writeData[9], clk, rst);
dff b11( out[10], writeData[10], clk, rst);
dff b12( out[11], writeData[11], clk, rst);
dff b13( out[12], writeData[12], clk, rst);
dff b14( out[13], writeData[13], clk, rst);
dff b15( out[14], writeData[14], clk, rst);
dff b16( out[15], writeData[15], clk, rst);

endmodule
