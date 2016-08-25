`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:10:59 08/23/2016 
// Design Name: 
// Module Name:    toplevel 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module toplevel(
    input wire clk, reset,
	 input wire switchR, switchG, switchB,
    output wire hsync, vsync,
    output wire [2:0] rgb
   );

	//declaracion de señales
   wire [9:0] pixel_x, pixel_y;
   wire video_on, pixel_tick;
   reg [2:0] rgb_reg;
   wire [2:0] rgb_next;

   Sincronizador uut_unit
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(pixel_tick),
       .pixel_x(pixel_x), .pixel_y(pixel_y));
		 
   gentextchap uuut_unit
      (.video_on(video_on), .pix_x(pixel_x), .pix_y(pixel_y),
       .graph_rgb(rgb_next), .switchR(switchR), .switchG(switchG), .switchB(switchB));
   
	// buffer rgb
   always @(negedge clk)
      if (pixel_tick)
         rgb_reg <= rgb_next;
   
	// salida
   assign rgb = rgb_reg;

endmodule
