`timescale 1ns / 10ps

module topcontrolrtc(
		input wire clk, reset,
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh, //viene del rtc.
		input wire lees, leem, leeh, leed, leems, leea,
		input wire confighora,
		input wire configfecha,
		input wire docehoras,
		input wire mandauno,
		//input wire configtempo,
		input wire leer, escribir, inicializar,
		input wire boton_aumenta, boton_disminuye, boton_izquierda, boton_derecha,
		output wire fkda, fkdb, fkdc, fkdd, fkde, fkdf, fkdg, fkdh, //va al rtc. y vga.
		output wire cs, rd, wr, ad,
		output wire lfkda, lfkdb, lfkdc, lfkdd, lfkde, lfkdf, lfkdg, lfkdh, //va a la vga.
		output wire fkaa, fkab, fkac, fkad, fkae, fkaf, fkag, fkah, //va al rtc.
		output wire ensec, enmin, enhour, enday, enmonth, enyear,
		output reg [7:0] datatovga
    );
	 
/*en el punto donde termino de leer poner bandera, para leer lo demas.*/

wire [6:0] countyears;
wire [5:0] countsecs;
wire [5:0] countmins;
wire [4:0] counthours;
wire [4:0] countdays;
wire [3:0] countmonths;
wire [1:0] countpam;
wire enini;
wire enwrite;
wire enread;
wire rda;
wire rdb;
wire rdc;
wire rdd;
wire rde;
wire rdf;
wire rdg;
wire rdh;
wire enabled;
wire enablel;
wire enablee;
wire configformato;
wire mandaunoa;
wire docehorasa;

//instanciacion de contadores

	contadorsegundos csecs (
		.clk(clk), 
		.boton_aumenta(boton_aumenta), 
		.boton_disminuye(boton_disminuye), 
		.countsecs(countsecs)
	);
	
	contadorano cyears (
		.clk(clk),
		.boton_aumenta(boton_aumenta),
		.boton_disminuye(boton_disminuye),
		.countyears(countyears)
	);
	
	contadordia cdays (
		.clk(clk),
		.boton_aumenta(boton_aumenta),
		.boton_disminuye(boton_disminuye),
		.countdays(countdays)
	);
	
	contadorhoras chours (
		.clk(clk),
		.boton_aumenta(boton_aumenta),
		.boton_disminuye(boton_disminuye),
		.counthours(counthours)
	);
	
	contadormes cmonths (
		.clk(clk),
		.boton_aumenta(boton_aumenta),
		.boton_disminuye(boton_disminuye),
		.countmonths(countmonths)
	);
	
	contadorminutos cmins (
		.clk(clk),
		.boton_aumenta(boton_aumenta),
		.boton_disminuye(boton_disminuye),
		.countmins(countmins)
	);
	
	countpam cpam (
		.clk(clk),
		.boton_derecha(boton_derecha),
		.boton_izquierda(boton_izquierda),
		.countpam(countpam)
	);
		
//instanciacion
	confighora ch (
		.clk(clk), 
		.reset(reset), 
		.confighora(confighora), 
		.configfecha(configfecha), 
		.docehoras(docehoras),
		.mandauno(mandauno),
		.inicializar(inicializar),
		.escribir(escribir),
		.leer(leer),
		.countsecs(countsecs),
		.countmins(countmins),
		.countmonths(countmonths),
		.countdays(countdays),
		.counthours(counthours),
		.countyears(countyears),
		.countpam(countpam),
		.lees(lees),
		.leem(leem),
		.leeh(leeh),
		.leed(leed),
		.leems(leems),
		.leea(leea),
		.configformato(configformato),
		.docehorasa(docehorasa),
		.mandaunoa(mandaunoa),
		.rda(rda), 
		.rdb(rdb), 
		.rdc(rdc), 
		.rdd(rdd), 
		.rde(rde), 
		.rdf(rdf), 
		.rdg(rdg), 
		.rdh(rdh), 
		.enini(enini), 
		.enwrite(enwrite), 
		.enread(enread), 
		.ensec(ensec), 
		.enmin(enmin), 
		.enhour(enhour), 
		.enday(enday), 
		.enmonth(enmonth), 
		.enyear(enyear)
	);

	nuevocontrol nc (
		.clk(clk), 
		.reset(reset), 
		.rda(rda), 
		.rdb(rdb), 
		.rdc(rdc), 
		.rdd(rdd), 
		.rde(rde), 
		.rdf(rdf), 
		.rdg(rdg), 
		.rdh(rdh), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.enini(enini), 
		.enwrite(enwrite), 
		.enread(enread), 
		.ensec(ensec), 
		.enmin(enmin), 
		.enhour(enhour), 
		.enday(enday), 
		.enmonth(enmonth), 
		.enyear(enyear), 
		.configformato(configformato), 
		.docehorasa(docehorasa),
		.mandaunoa(mandaunoa),
		.enablee(enablee), 
		.enabled(enabled), 
		.enablel(enablel), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ad(ad), 
		.fkaa(fkaa), 
		.fkab(fkab), 
		.fkac(fkac), 
		.fkad(fkad), 
		.fkae(fkae), 
		.fkaf(fkaf), 
		.fkag(fkag), 
		.fkah(fkah), 
		.lfkda(lfkda), 
		.lfkdb(lfkdb), 
		.lfkdc(lfkdc), 
		.lfkdd(lfkdd), 
		.lfkde(lfkde), 
		.lfkdf(lfkdf), 
		.lfkdg(lfkdg), 
		.lfkdh(lfkdh), 
		.fkda(fkda), 
		.fkdb(fkdb), 
		.fkdc(fkdc), 
		.fkdd(fkdd), 
		.fkde(fkde), 
		.fkdf(fkdf), 
		.fkdg(fkdg), 
		.fkdh(fkdh)
	);
	
	always @* begin
		if (leer)
			datatovga = {lfkda, lfkdb, lfkdc, lfkdd, lfkde, lfkdf, lfkdg, lfkdh};
		if (escribir)
			datatovga = {fkda, fkdb, fkdc, fkdd, fkde, fkdf, fkdg, fkdh};
	end
	
	
endmodule
