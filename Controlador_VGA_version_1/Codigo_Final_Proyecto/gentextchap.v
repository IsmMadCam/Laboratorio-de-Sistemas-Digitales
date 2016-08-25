`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:07 08/23/2016 
// Design Name: 
// Module Name:    gentextchap 
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
module gentextchap
	(
	 input wire video_on,
    input wire [9:0] pix_x, pix_y,
	 input wire switchR, switchG, switchB,
    output reg [2:0] graph_rgb
	);
	
	// declaracion de constantes y señales
   // coordenadas x,y desde (0,0) hasta (640,480)
   localparam MAX_X = 640;
   localparam MAX_Y = 480;

	//tamaño de letra
   localparam LETTER_SIZE = 8;
	
   wire [9:0] letter_x_l, letter_x_r;
   wire [9:0] letter_y_t, letter_y_b;
   wire [2:0] rom_addr, rom_col;
   reg [7:0] rom_data;
   wire rom_bit;
	wire sq_letter_on, letter_on;
  
	//k
  
	wire [9:0] letter_x_l_k, letter_x_r_k;
   wire [9:0] letter_y_t_k, letter_y_b_k;
   wire [2:0] rom_addr_k, rom_col_k;
   reg [7:0] rom_data_k;
   wire rom_bit_k;
	wire sq_letter_on_k, letter_on_k;
	
	//r
	
	wire [9:0] letter_x_l_r, letter_x_r_r;
   wire [9:0] letter_y_t_r, letter_y_b_r;
   wire [2:0] rom_addr_r, rom_col_r;
   reg [7:0] rom_data_r;
   wire rom_bit_r;
	wire sq_letter_on_r, letter_on_r;
	
	//
	
	wire [2:0] letter_rgb;
	
	//initials
	always @*
	case (rom_addr)
		3'h0: rom_data = 16'b00111100; //   ****
      3'h1: rom_data = 16'b00011000; //    **
      3'h2: rom_data = 16'b00011000; //    **
      3'h3: rom_data = 16'b00011000; //    **
      3'h4: rom_data = 16'b00011000; //    **
      3'h5: rom_data = 16'b00011000; //    **
      3'h6: rom_data = 16'b00011000; //    **
      3'h7: rom_data = 16'b00111100; //   ****
	endcase
	
	always @*
	case (rom_addr_k)
		3'h0: rom_data_k = 8'b01100110; //  **  **
      3'h1: rom_data_k = 8'b01100110; //  **  **
      3'h2: rom_data_k = 8'b00110110; //  ** ** 
      3'h3: rom_data_k = 8'b00011110; //  **** 
      3'h4: rom_data_k = 8'b00011110; //  **** 
      3'h5: rom_data_k = 8'b00110110; //  ** ** 
      3'h6: rom_data_k = 8'b01100110; //  **  **
      3'h7: rom_data_k = 8'b01100110; //  **  **
	endcase

	always @*
	case (rom_addr_r)
		3'h0: rom_data_r = 8'b11110011; // ******
      3'h1: rom_data_r = 8'b01100110; //  **  **
      3'h2: rom_data_r = 8'b01100110; //  **  **
      3'h3: rom_data_r = 8'b11100011; //  *****
      3'h4: rom_data_r = 8'b01100011; //  ** **
      3'h5: rom_data_r = 8'b01100110; //  **  **
      3'h6: rom_data_r = 8'b01100110; //  **  **
      3'h7: rom_data_r = 8'b01110110; // ***  **
	endcase
	
//unico para cada letra -------------------------------------
   assign letter_x_l = 320;
   assign letter_y_t = 240;
   assign letter_x_r = letter_x_l + LETTER_SIZE - 1;
   assign letter_y_b = letter_y_t + LETTER_SIZE - 1;
   // pixel within ball
   assign sq_letter_on =
            (letter_x_l<=pix_x) && (pix_x<=letter_x_r) &&
            (letter_y_t<=pix_y) && (pix_y<=letter_y_b);
   // map current pixel location to ROM addr/col
   assign rom_addr = pix_y[2:0] - letter_y_t[2:0];
   assign rom_col = pix_x[2:0] - letter_x_l[2:0];
   assign rom_bit = rom_data[rom_col];
	
	// pixel within ball
   assign letter_on = sq_letter_on & rom_bit;
	
	//para la k.
	assign letter_x_l_k = 300;
   assign letter_y_t_k = 240;
   assign letter_x_r_k = letter_x_l_k + LETTER_SIZE - 1;
   assign letter_y_b_k = letter_y_t_k + LETTER_SIZE - 1;
   // pixel within ball
   assign sq_letter_on_k =
            (letter_x_l_k<=pix_x) && (pix_x<=letter_x_r_k) &&
            (letter_y_t_k<=pix_y) && (pix_y<=letter_y_b_k);
   // map current pixel location to ROM addr/col
   assign rom_addr_k = pix_y[2:0] - letter_y_t_k[2:0];
   assign rom_col_k = pix_x[2:0] - letter_x_l_k[2:0];
   assign rom_bit_k = rom_data_k[rom_col_k];
	
	// pixel within ball
   assign letter_on_k = sq_letter_on_k & rom_bit_k;
	
	//para la r.
	assign letter_x_l_r = 340;
   assign letter_y_t_r = 240;
   assign letter_x_r_r = letter_x_l_r + LETTER_SIZE - 1;
   assign letter_y_b_r = letter_y_t_r + LETTER_SIZE - 1;
   // pixel within ball
   assign sq_letter_on_r =
            (letter_x_l_r<=pix_x) && (pix_x<=letter_x_r_r) &&
            (letter_y_t_r<=pix_y) && (pix_y<=letter_y_b_r);
   // map current pixel location to ROM addr/col
   assign rom_addr_r = pix_y[2:0] - letter_y_t_r[2:0];
   assign rom_col_r = pix_x[2:0] - letter_x_l_r[2:0];
   assign rom_bit_r = rom_data_r[rom_col];
	
	// pixel within ball
   assign letter_on_r = sq_letter_on_r & rom_bit_r;
	
//------------------------------------------------------------
   // ball rgb output
	assign letter_rgb[2] = switchR;   // red
	assign letter_rgb[1] = switchG;   // green
	assign letter_rgb[0] = switchB;   // blue
	
   // rgb multiplexing circuit
   //--------------------------------------------
   always @*
      if (~video_on)
         graph_rgb = 3'b000; // black
      else
			if (letter_on|letter_on_k|letter_on_r)
            graph_rgb = letter_rgb;
         else
            graph_rgb = 3'b000; // black background

endmodule
