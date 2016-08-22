`timescale 1ns / 10ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:53:41 08/21/2016 
// Design Name: 
// Module Name:    ControladorrrVGA 
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
module ControladorrrVGA(
	input wire reset,
	input wire clk,
	output wire hsync , vsync , video_on, p_tick,
	output wire [2:0] text_on,
	output reg [2:0] text_rgb
    );
	 
	wire [9:0] pix_x, pix_y;
	
	 
	 
	 
//------------------------------------------Sincronizador.-----------------------------------------------------	 
	 
	   // declaracion de constantes
		// VGA 640-by-480 sync parameters
	localparam HD = 640; // area de display horizontal
	localparam HF = 48 ; //borde izquierdo
	localparam HB = 16 ; //borde derecho
	localparam HR = 96 ; // retraso horizonal
	localparam VD = 480; // area de display vertical
	localparam VF = 10; // borde superior
	localparam VB = 33; // borde inferior
	localparam VR = 2; // retraso vertical
	
	// mod-2 counter
	reg mod2_reg;
	wire mod2_next ;
	// sync counters
	reg [9:0] h_count_reg, h_count_next;
	reg [9:0] v_count_reg , v_count_next ;
	// output buffer
	reg v_sync_reg , h_sync_reg ;
	wire v_sync_next , h_sync_next ;
	// señal de estado
	wire h_end , v_end , pixel_tick;
	
	// cuerpo del registro

	always @( posedge clk , posedge reset)
		if (reset)
			begin
			mod2_reg <= 1'b0;
			v_count_reg <= 0;
			h_count_reg <= 0;
			v_sync_reg <= 1'b0;
			h_sync_reg <= 1'b0;
		end
		else
			begin
			mod2_reg <= mod2_next ;
			v_count_reg <= v_count_next;
			h_count_reg <= h_count_next;
			v_sync_reg <= v_sync_next ;
			h_sync_reg <= h_sync_next ;
		end
		
		//circuito mod-2 para generar un tick de habilitacion de 25 MHz
	assign mod2_next = ~mod2_reg;
	assign pixel_tick = mod2_reg;
	// señales de estado
	// final del contador horizontal (799)
	assign h_end = (h_count_reg == (HD+HF+HB+HR-1));
	// final del contador vertical (524)
	assign v_end = (v_count_reg ==(VD+VF+VB+VR-1));
	
	//logica de estado siguiente para contador de sincronizacion horizontal mod-800.
	always @*
		if (pixel_tick) // Pulso de 25 MHz.
			if (h_end)
				h_count_next = 0;
			else
				h_count_next = h_count_reg + 1;
		else
			h_count_next = h_count_reg;
			
	//logica de estado siguiente para contador de sincronizacion vertical mod-525.
	always @*
		if(pixel_tick & h_end)
			if (v_end)
				v_count_next = 0;
			else 
				v_count_next = v_count_reg + 1;
		else
			v_count_next = v_count_reg;
			
	assign h_sync_next = (h_count_reg >= (HD+HB) && h_count_reg <= (HD+HB+HR-1));
	assign v_sync_next = (v_count_reg >= (VD+VB) && v_count_reg <= (VD+VB+VR-1));
	
	//video on/off
	
	assign video_on = (h_count_reg < HD) && (v_count_reg < VD);
	
	//salida
	assign hsync = h_sync_reg;
	assign vsync = v_sync_reg;
	assign pix_x = h_count_reg;
	assign pix_y = v_count_reg;
	assign p_tick = pixel_tick;
	
	
	
	
	
	
	
	
//---------------------------------------- GENERADOR DE TEXTO. ------------------------------------------------
	
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
