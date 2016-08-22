`timescale 1ns / 10ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   18:28:52 08/21/2016
// Design Name:   ControladorrrVGA
// Module Name:   C:/Users/Kevin/ControlVGACompleto/TestBenchCompleto.v
// Project Name:  ControlVGACompleto
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ControladorrrVGA
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBenchCompleto;

	// Inputs
	reg reset;
	reg clk;

	// Outputs
	wire hsync;
	wire vsync;
	wire video_on;
	wire p_tick;
	wire [2:0] text_on;
	wire [2:0] text_rgb;

	// Instantiate the Unit Under Test (UUT)
	ControladorrrVGA uut (
		.reset(reset), 
		.clk(clk), 
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(p_tick), 
		.text_on(text_on), 
		.text_rgb(text_rgb)
	);
	
	always begin #5 clk = !clk; end
	
	initial 
	begin
		clk = 0;
		reset = 1;
		#100;
		reset =0;
		#1000000;
		$finish;
			
	end
      
endmodule

