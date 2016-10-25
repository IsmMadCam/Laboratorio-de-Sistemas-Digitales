`timescale 1ns / 10ps

module metadisminuir(
		input boton_disminuye,
		input clk,
		output disminuir
    );

reg FF_1;
reg FF_2;
reg FF_3;
reg FF_4;
reg FF_5;

always @(posedge clk)
begin
	FF_1 <= boton_disminuye;
	FF_2 <= FF_1;
	FF_3 <= FF_2;
	FF_4 <= FF_3;
	FF_5 <= FF_4;
end

assign disminuir = !((FF_1) & (FF_2) & (FF_3) & (FF_4) & (FF_5) & (!boton_disminuye));
endmodule
