`timescale 1ns / 10ps

module topleeveel(
    input wire clk, reset,
	 input wire day, mes, year, hour, min, second, /* thour1, thour2, tmin1, tmin2, tsec1, tsec2, */
    output wire hsync, vsync,
    output wire [2:0] rgb
    );

	//declaracion de señales
   wire [9:0] pixel_x, pixel_y;
   wire video_on, pixel_tick;
	wire ef_on;
	wire etemp_on;
	wire eh_on;
	wire date_on;
	wire hour_on;
	wire timer_on;
	wire e_on;
	wire am_on;
	wire pm_on;
	wire ring_on;
   reg [2:0] rgb_reg;
   reg [2:0] rgb_next;

   Sincronizador uut_unit
      (.clk(clk), .reset(reset), .hsync(hsync), .vsync(vsync),
       .video_on(video_on), .p_tick(pixel_tick),
       .pixel_x(pixel_x), .pixel_y(pixel_y));
		 
   Generador uuut_unit
      (.clk(clk), .day(day), .mes(mes), .year(year),
		.hour(hour), .min(min), .second(second),
		/*.thour1(thour1), .thour2(thour2), .tmin1(tmin1), .tmin2(tmin2), .tsec1(tsec1), .tsec2(tsec2), */
		.pix_x(pixel_x), .pix_y(pixel_y)/*, .text_on(text_on)*/, .text_rgb(text_rgb), .ef_on(ef_on), .etemp_on(etemp_on),
		.eh_on(eh_on), .date_on(date_on), .hour_on(hour_on), .timer_on(timer_on), .e_on(e_on), .am_on(am_on),
		.pm_on(pm_on), .ring_on(ring_on));
	
   
	// buffer rgb
   always @(negedge clk)
      if (pixel_tick)
         rgb_reg <= rgb_next;
	
	always @*
		if (~video_on)
			rgb_next = 3'b000/*"000"*/;
		else
			if (ef_on || etemp_on || eh_on || date_on || hour_on || timer_on || e_on || am_on || pm_on || ring_on)
				rgb_next = text_rgb;
			else
				rgb_next = 3'b000;
			
	// salida
   assign rgb = rgb_reg;
endmodule
