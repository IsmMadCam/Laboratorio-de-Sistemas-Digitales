`timescale 1ns / 10ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:26:58 08/18/2016
// Design Name:   Sincronizador
// Module Name:   C:/Users/Kevin/Laboratorio/clk.v
// Project Name:  Laboratorio
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Sincronizador
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module clk;

	// Inputs
	reg reset;
	reg clk;

	// Outputs
	wire hsync;
	wire vsync;
	wire video_on;
	wire p_tick;
	wire [9:0] pixel_x;
	wire [9:0] pixel_y;

	// Instantiate the Unit Under Test (UUT)
	Sincronizador uut (
		.reset(reset), 
		.clk(clk), 
		.hsync(hsync), 
		.vsync(vsync), 
		.video_on(video_on), 
		.p_tick(p_tick), 
		.pixel_x(pixel_x), 
		.pixel_y(pixel_y)
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

