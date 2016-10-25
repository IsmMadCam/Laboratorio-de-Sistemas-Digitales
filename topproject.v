`timescale 1ns / 10ps

module topproject(
		input wire clk, reset,
		input wire rstregdays, rstregmonths, rstregyears, rstregsecs, rstregmins, rstreghours,
		input wire confighora, configfecha, 
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
		input wire escribir, inicializar, leer, docehoras, mandauno,
		input wire boton_izquierda, boton_derecha, boton_aumenta, boton_disminuye,
		output wire datortc, dbtortc, dctortc, ddtortc, detortc, dftortc, dgtortc, dhtortc,
		output wire hsync, vsync, 
		output wire [2:0] rgb,
		output wire cs, rd, wr, ad
    );
	 
wire dartc;
wire dbrtc;
wire dcrtc;
wire ddrtc;
wire dertc;
wire dfrtc;
wire dgrtc;
wire dhrtc;
wire listo;
wire listoe;
wire listod;

	 controladorrtc controladorrtcfin (
		.clk(clk), 
		.reset(reset), 
		.rstregdays(rstregdays), 
		.rstregmonths(rstregmonths), 
		.rstregyears(rstregyears), 
		.rstregmins(rstregmins), 
		.rstregsecs(rstregsecs), 
		.rstreghours(rstreghours), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.confighora(confighora), 
		.configfecha(configfecha), 
		.inicializar(inicializar), 
		.leer(leer), 
		.escribir(escribir), 
		.docehoras(docehoras), 
		.mandauno(mandauno), 
		.boton_izquierda(boton_izquierda), 
		.boton_derecha(boton_derecha), 
		.boton_aumenta(boton_aumenta), 
		.boton_disminuye(boton_disminuye), 
		.dartc(dartc), 
		.dbrtc(dbrtc), 
		.dcrtc(dcrtc), 
		.ddrtc(ddrtc), 
		.dertc(dertc), 
		.dfrtc(dfrtc), 
		.dgrtc(dgrtc), 
		.dhrtc(dhrtc), 
		.hsync(hsync), 
		.vsync(vsync), 
		.listo(listo),
		.listoe(listoe),
		.listod(listod),
		.rgb(rgb), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ad(ad)
	);
	
	buffer buff (
		.listo(listo),
		.listoe(listoe),
		.listod(listod),
		.dartc(dartc), 
		.dbrtc(dbrtc), 
		.dcrtc(dcrtc), 
		.ddrtc(ddrtc), 
		.dertc(dertc), 
		.dfrtc(dfrtc), 
		.dgrtc(dgrtc), 
		.dhrtc(dhrtc), 
		.datortc(datortc), 
		.dbtortc(dbtortc), 
		.dctortc(dctortc), 
		.ddtortc(ddtortc), 
		.detortc(detortc), 
		.dftortc(dftortc), 
		.dgtortc(dgtortc), 
		.dhtortc(dhtortc)
	);

endmodule
