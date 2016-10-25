`timescale 1ns / 10ps

module controladorrtc(
		input wire clk, reset,
		input wire rstregdays, rstregmonths, rstregyears, rstregmins, rstregsecs, rstreghours,
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
		input wire confighora, configfecha, inicializar, leer, escribir, docehoras, mandauno,
		input wire boton_izquierda, boton_derecha, boton_aumenta, boton_disminuye,
		output wire dartc, dbrtc, dcrtc, ddrtc, dertc, dfrtc, dgrtc, dhrtc,
		output wire hsync, vsync,
		output wire listo,
		output wire listoe, listod, 
		output wire [2:0] rgb,
		output wire cs, rd, wr, ad
    );

//declaracion de señales
	wire [3:0] ytens;
	wire [3:0] yones;
	wire [3:0] mtens;
	wire [3:0] mones;
	wire [3:0] dtens;
	wire [3:0] dones;
	wire [3:0] htens;
	wire [3:0] hones;
	wire [3:0] mintens;
	wire [3:0] minones;
	wire [3:0] tens;
	wire [3:0] ones;
	wire lees;
	wire leem;
	wire leeh;
	wire leed;
	wire leems;
	wire leea;
	wire ensec;
	wire enmin;
	wire enhour;
	wire enday;
	wire enmonth;
	wire enyear;
	wire listoescritura;
	wire listolectura;
	wire listodireccion;
	wire leerdays;
	wire escribirdays;
	wire leerseconds;
	wire escribirseconds;
	wire leerhours;
	wire escribirhours;
	wire leerminutes;
	wire escribirminutes;
	wire leermonths;
	wire escribirmonths;
	wire leeryears;
	wire escribiryears;
	wire [3:0] day1;
	wire [3:0] day2;
	wire [3:0] hour1;
	wire [3:0] hour2;
	wire [3:0] min1;
	wire [3:0] min2;
	wire [3:0] month1;
	wire [3:0] month2;
	wire [3:0] second1;
	wire [3:0] second2;
	wire [3:0] year1;
	wire [3:0] year2;
	wire lfkda;
	wire lfkdb;
	wire lfkdc;
	wire lfkdd;
	wire lfkde;
	wire lfkdf;
	wire lfkdg;
	wire lfkdh;
	wire fkaa;
	wire fkab;
	wire fkac;
	wire fkad;
	wire fkae;
	wire fkaf;
	wire fkag;
	wire fkah;
	wire fkda;
	wire fkdb;
	wire fkdc;
	wire fkdd;
	wire fkde;
	wire fkdf;
	wire fkdg;
	wire fkdh;
	//wire lrda;
	//wire lrdb;
	//wire lrdc;
	//wire lrdd;
	//wire lrde;
	//wire lrdf;
	//wire lrdg;
	//wire lrdh;


//instanciacion control del rtc
	toprtc topdelrtc (
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
		.ytens(ytens), 
		.yones(yones), 
		.mtens(mtens), 
		.mones(mones), 
		.dtens(dtens), 
		.dones(dones), 
		.htens(htens), 
		.hones(hones), 
		.mintens(mintens), 
		.minones(minones), 
		.tens(tens), 
		.ones(ones), 
		.lees(lees), 
		.leem(leem), 
		.leeh(leeh), 
		.leed(leed), 
		.leems(leems), 
		.leea(leea), 
		.listo(listo), 
		.listoe(listoe),
		.listod(listod),
		.fkaa(fkaa), 
		.fkab(fkab), 
		.fkac(fkac), 
		.fkad(fkad), 
		.fkae(fkae), 
		.fkaf(fkaf), 
		.fkag(fkag), 
		.fkah(fkah), 
		.fkda(fkda), 
		.fkdb(fkdb), 
		.fkdc(fkdc), 
		.fkdd(fkdd), 
		.fkde(fkde), 
		.fkdf(fkdf), 
		.fkdg(fkdg), 
		.fkdh(fkdh), 
		.lfkda(lfkda), 
		.lfkdb(lfkdb), 
		.lfkdc(lfkdc), 
		.lfkdd(lfkdd), 
		.lfkde(lfkde), 
		.lfkdf(lfkdf), 
		.lfkdg(lfkdg), 
		.lfkdh(lfkdh), 
		.ensec(ensec), 
		.enmin(enmin), 
		.enhour(enhour), 
		.enday(enday), 
		.enmonth(enmonth), 
		.enyear(enyear), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ad(ad), 
		.listoescritura(listoescritura), 
		.listolectura(listolectura),
		.listodireccion(listodireccion)
	);
	
//instanciacion control de los registros

	controlregistros uut (
		.clk(clk), 
		.reset(reset), 
		.ensec(ensec), 
		.enmin(enmin), 
		.enhour(enhour), 
		.enday(enday), 
		.enmonth(enmonth), 
		.enyear(enyear), 
		.listo(listo), 
		.escribir(escribir), 
		.lees(lees), 
		.leem(leem), 
		.leeh(leeh), 
		.leed(leed), 
		.leems(leems), 
		.leea(leea), 
		.listoescritura(listoescritura), 
		.listolectura(listolectura), 
		.leerdays(leerdays), 
		.escribirdays(escribirdays), 
		.leersecs(leersecs), 
		.escribirsecs(escribirsecs), 
		.leerhours(leerhours), 
		.escribirhours(escribirhours), 
		.leermins(leermins), 
		.escribirmins(escribirmins), 
		.leermonths(leermonths), 
		.escribirmonths(escribirmonths), 
		.leeryears(leeryears), 
		.escribiryears(escribiryears)
	);
	
//instanciacion de registros.

	regdays registerdays (
		.rstregdays(rstregdays), 
		.clk(clk),
		.leerdays(leerdays), 
		.escribirdays(escribirdays), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.dtens(dtens), 
		.dones(dones), 
		.day1(day1), 
		.day2(day2)
	);
	
	reghours registerhours (
		.rstreghours(rstreghours), 
		.clk(clk),
		.leerhours(leerhours), 
		.escribirhours(escribirhours), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.htens(htens), 
		.hones(hones), 
		.hour1(hour1), 
		.hour2(hour2)
	);
	
	regminutes registerminutes (
		.rstregmins(rstregmins), 
		.clk(clk),
		.leermins(leermins), 
		.escribirmins(escribirmins), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.mintens(mintens), 
		.minones(minones), 
		.min1(min1), 
		.min2(min2)
	);
	
	regmonths registermonths (
		.rstregmonths(rstregmonths), 
		.clk(clk),
		.leermonths(leermonths), 
		.escribirmonths(escribirmonths), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.mtens(mtens), 
		.mones(mones), 
		.month1(month1), 
		.month2(month2)
	);
	
	regseconds registerseconds (
		.rstregsecs(rstregsecs), 
		.clk(clk),
		.leersecs(leersecs), 
		.escribirsecs(escribirsecs), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.tens(tens), 
		.ones(ones), 
		.second1(second1), 
		.second2(second2)
	);
	
	regyears registeryears (
		.rstregyears(rstregyears), 
		.clk(clk),
		.leeryears(leeryears), 
		.escribiryears(escribiryears), 
		.lrda(lrda), 
		.lrdb(lrdb), 
		.lrdc(lrdc), 
		.lrdd(lrdd), 
		.lrde(lrde), 
		.lrdf(lrdf), 
		.lrdg(lrdg), 
		.lrdh(lrdh), 
		.ytens(ytens), 
		.yones(yones), 
		.year1(year1), 
		.year2(year2)
	);
	
// controlador vga
	controladorvga vga (
		.clk(clk), 
		.reset(reset), 
		.day1(day1), 
		.day2(day2), 
		.month1(month1), 
		.month2(month2), 
		.year1(year1), 
		.year2(year2), 
		.hour1(hour1), 
		.hour2(hour2), 
		.min1(min1), 
		.min2(min2), 
		.second1(second1), 
		.second2(second2), 
		.hsync(hsync), 
		.vsync(vsync), 
		.rgb(rgb)
	);

// data to rtc

datatortc datatortcdef (
		.clk(clk),
		.reset(reset),
		.fkda(fkda), 
		.fkdb(fkdb), 
		.fkdc(fkdc), 
		.fkdd(fkdd), 
		.fkde(fkde), 
		.fkdf(fkdf), 
		.fkdg(fkdg), 
		.fkdh(fkdh), 
		.fkaa(fkaa), 
		.fkab(fkab), 
		.fkac(fkac), 
		.fkad(fkad), 
		.fkae(fkae), 
		.fkaf(fkaf), 
		.fkag(fkag), 
		.fkah(fkah), 
		.listoe(listoe),
		.listod(listod),
		.dartc(dartc),
		.dbrtc(dbrtc),
		.dcrtc(dcrtc),
		.ddrtc(ddrtc),
		.dertc(dertc),
		.dfrtc(dfrtc),
		.dgrtc(dgrtc),
		.dhrtc(dhrtc)
	);
	
endmodule
