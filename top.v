`timescale 1ns / 1ps

module top(
		input wire clk, reset,
		input wire leer, escribir, inicializar, 
		input wire boton_aumenta, boton_disminuye, boton_izquierda, boton_derecha, 
		input wire confighora, configfecha, docehoras, mandauno,
		output reg dartc, dbrtc, dcrtc, ddrtc, dertc, dfrtc, dgrtc, dhrtc, 
		output wire hsync,
		output wire vsync,
		output wire [2:0] rgb,
		output wire cs, rd, wr, ad,
		output wire fkaa, fkab, fkac, fkad, fkae, fkaf, fkag, fkah	
    );

	reg lees;
	reg leem;
	reg leeh;
	reg leed;
	reg leems;
	reg leea;
	
	wire ensec;
	wire enmin;
	wire enhour;
	wire enday;
	wire enmonth;
	wire enyear;
	wire [7:0] datatovga;
	
	wire lrda;
	wire lrdb;
	wire lrdc;
	wire lrdd;
	wire lrde;
	wire lrdf;
	wire lrdg;
	wire lrdh;
	
	wire fkda;
	wire fkdb;
	wire fkdc;
	wire fkdd;
	wire fkde;
	wire fkdf;
	wire fkdg;
	wire fkdh;
	
	reg [7:0] day;
	reg [7:0] mes;
	reg [7:0] year;
	reg [7:0] hour;
	reg [7:0] min;
	reg [7:0] second;
	
	always @* begin
		if (leer) begin
			dartc = lrda;
			dbrtc = lrdb;
			dcrtc = lrdc;
			ddrtc = lrdd;
			dertc = lrde;
			dfrtc = lrdf;
			dgrtc = lrdg;
			dhrtc = lrdh;
		end
		if (escribir) begin
			dartc = fkda;
			dbrtc = fkdb;
			dcrtc = fkdc;
			ddrtc = fkdd;
			dertc = fkde;
			dfrtc = fkdf;
			dgrtc = fkdg;
			dhrtc = fkdh;
		end
	end
	
	always @* begin //para ver los datos en pantalla.
		if ((escribir)&&(ensec))
			second = datatovga;
		if ((escribir)&&(enmin))
			min = datatovga;
		if ((escribir)&&(enhour))
			hour = datatovga;
		if ((escribir)&&(enday))
			day = datatovga;
		if ((escribir)&&(enmonth))
			mes = datatovga;
		if ((escribir)&&(enyear))
			year = datatovga;
		if ((leer)&&(ensec))
			lees = 1;
		if ((leer)&&(enmin))
			leem = 1;
		if ((leer)&&(enhour))
			leeh = 1;
		if ((leer)&&(enday))
			leed = 1;
		if ((leer)&&(enmonth))
			leems = 1;
		if ((leer)&&(enyear))
			leea = 1;
	end


	// Instantiate the Unit Under Test (UUT)
	topcontrolrtc controlrtc (
		.clk(clk), 
		.reset(reset), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.lees(lees), 
		.leem(leem), 
		.leeh(leeh), 
		.leed(leed), 
		.leems(leems), 
		.leea(leea), 
		.confighora(confighora), 
		.configfecha(configfecha), 
		.docehoras(docehoras), 
		.mandauno(mandauno), 
		.leer(leer), 
		.escribir(escribir), 
		.inicializar(inicializar), 
		.boton_aumenta(boton_aumenta), 
		.boton_disminuye(boton_disminuye), 
		.boton_izquierda(boton_izquierda), 
		.boton_derecha(boton_derecha), 
		.fkda(fkda), 
		.fkdb(fkdb), 
		.fkdc(fkdc), 
		.fkdd(fkdd), 
		.fkde(fkde), 
		.fkdf(fkdf), 
		.fkdg(fkdg), 
		.fkdh(fkdh), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ad(ad), 
		.lfkda(lfkda), 
		.lfkdb(lfkdb), 
		.lfkdc(lfkdc), 
		.lfkdd(lfkdd), 
		.lfkde(lfkde), 
		.lfkdf(lfkdf), 
		.lfkdg(lfkdg), 
		.lfkdh(lfkdh), 
		.fkaa(fkaa), 
		.fkab(fkab), 
		.fkac(fkac), 
		.fkad(fkad), 
		.fkae(fkae), 
		.fkaf(fkaf), 
		.fkag(fkag), 
		.fkah(fkah), 
		.ensec(ensec), 
		.enmin(enmin), 
		.enhour(enhour), 
		.enday(enday), 
		.enmonth(enmonth), 
		.enyear(enyear), 
		.datatovga(datatovga)
	);

	// Instantiate the Unit Under Test (UUT)
	topleeveel controladorvga (
		.clk(clk), 
		.reset(reset), 
		.day(day), 
		.mes(mes), 
		.year(year), 
		.hour(hour), 
		.min(min), 
		.second(second), 
		.hsync(hsync), 
		.vsync(vsync), 
		.rgb(rgb)
	);

endmodule
