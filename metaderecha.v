`timescale 1ns / 10ps

module metaderecha(
		input boton_derecha,
		input clk,
		output derecha
    );

reg FF_1;
reg FF_2;
reg FF_3;
reg FF_4;
reg FF_5;

always @(posedge clk)
begin
	FF_1 <= boton_derecha;
	FF_2 <= FF_1;
	FF_3 <= FF_2;
	FF_4 <= FF_3;
	FF_5 <= FF_4;
end

assign derecha = !((FF_1) & (FF_2) & (FF_3) & (FF_4) & (FF_5) & (!boton_derecha));
endmodule
