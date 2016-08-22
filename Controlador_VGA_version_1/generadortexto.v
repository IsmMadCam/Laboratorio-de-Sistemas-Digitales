`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:59:41 08/20/2016 
// Design Name: 
// Module Name:    generadortexto 
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
module generadortexto
	(
		input wire clk,
		input wire [9:0] pix_x, pix_y,
		output wire [2:0] text_on,
		output reg [2:0] text_rgb
	);
	
	//declaracion de señales
	wire [10:0] rom_addr;
   
	reg [6:0] char_addr, char_addr_k, char_addr_i, char_addr_r;
	
	reg [3:0] row_addr;
   wire [3:0] row_addr_k, row_addr_i, row_addr_r;
	
	reg [2:0] bit_addr;
   wire [2:0] bit_addr_k, bit_addr_i, bit_addr_r;
	
	wire [7:0] font_word;
	wire font_bit, k_on, i_on, r_on;
	
	//instanciacion de la ROM
	font_rom font_unit
		(.clk(clk), .addr(rom_addr), .data(font_word));
	
	//----------------------------------------------------------------------------------------------------------
	// k region
	// displays k's initials.
	// scale: 64 by 128
	// 
	//----------------------------------------------------------------------------------------------------------
	assign k_on = (pix_y[9:5] == 2) && (3 <= pix_x[9:6]) && (pix_x[9:6] <= 6);
	assign row_addr_k = pix_y[6:3]; //escalamiento/tamaño en y.
	assign bit_addr_k = pix_x[5:3]; //escalamiento/tamaño en x.
	always @*
		case (pix_x[8:6])
			3'o3: char_addr_k = 7'h4b; //K
			3'o4: char_addr_k = 7'h4d; //M
			3'o5: char_addr_k = 7'h53; //S
			default: char_addr_k = 7'h00;
		endcase
	//----------------------------------------------------------------------------------------------------------
	// i region
	// displays i's initials.
	// scale: 64 by 128
	//
	//----------------------------------------------------------------------------------------------------------
	assign i_on = (pix_y[9:6] == 2) && (3 <= pix_x[9:6]) && (pix_x[9:6] <= 6);
	assign row_addr_i = pix_y[6:3]; //escalamiento/tamaño en y.
	assign bit_addr_i = pix_x[5:3]; //escalamiento/tamaño en x.	
	always @*
		case (pix_x[8:6])
			3'o3: char_addr_i = 7'h49; //I
			3'o4: char_addr_i = 7'h4d; //M
			3'o5: char_addr_i = 7'h43; //C
			default: char_addr_i = 7'h00;
		endcase
	//----------------------------------------------------------------------------------------------------------
	// r region
	// displays r's initials.
	// scale: 64 by 128
	//
	//----------------------------------------------------------------------------------------------------------
	assign r_on = (pix_y[9:7] == 2) && (3 <= pix_x[9:6]) && (pix_x[9:6] <= 6);
	assign row_addr_r = pix_y[6:3]; //escalamiento/tamaño en y.
	assign bit_addr_r = pix_x[5:3]; //escalamiento/tamaño en x.		
	always @*
		case (pix_x[8:6])
			3'o3: char_addr_r = 7'h52; //R
			3'o4: char_addr_r = 7'h4a; //J
			3'o5: char_addr_r = 7'h45; //E
			default: char_addr_r = 7'h00;	
		endcase
		
	//----------------------------------------------------------------------------------------------------------
	// MUX para las direcciones de la ROM y RGB
	//----------------------------------------------------------------------------------------------------------
	always @*
	begin
	
		text_rgb = 3'b000; // background, black
		if (k_on)
			begin
				char_addr = char_addr_k;
				row_addr = row_addr_k;
				bit_addr = bit_addr_k;
				if (font_bit)
					text_rgb = 3'b100; //iniciales en color rojo.
			end
		else if (i_on)
			begin
				char_addr = char_addr_i;
				row_addr = row_addr_i;
				bit_addr = bit_addr_i;
				if (font_bit)
					text_rgb = 3'b001; //iniciales en color verde.
			end
		else if (r_on)
			begin
				char_addr = char_addr_r;
				row_addr = row_addr_r;
				bit_addr = bit_addr_r;
				if (font_bit)
					text_rgb = 3'b010; //iniciales en color azul.
			end
	end
	
	assign text_on = {k_on, i_on, r_on};
	
	//interfaz de la ROM
	
	assign rom_addr = {char_addr, row_addr};
	assign font_not = font_word[~bit_addr];
	
endmodule
