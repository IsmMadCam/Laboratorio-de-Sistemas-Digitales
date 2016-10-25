`timescale 1ns / 10ps

module toprtc(
		input wire clk, reset,
		input wire lrda, lrdb, lrdc, lrdd, lrde, lrdf, lrdg, lrdh,
		input wire confighora, configfecha, inicializar, leer, escribir,  docehoras, mandauno, 
		input wire boton_izquierda, boton_derecha, boton_aumenta, boton_disminuye,
		output wire [3:0] ytens, yones, mtens, mones, dtens, dones, htens, hones, mintens, minones, tens, ones, //van a los registros.
		output wire lees, leem, leeh, leed, leems, leea,
		output wire listo,
		output wire listoe, listod,
		output wire fkaa, fkab, fkac, fkad, fkae, fkaf, fkag, fkah,
		output wire fkda, fkdb, fkdc, fkdd, fkde, fkdf, fkdg, fkdh,
		output wire lfkda, lfkdb, lfkdc, lfkdd, lfkde, lfkdf, lfkdg, lfkdh,
		output wire ensec, enmin, enhour, enday, enmonth, enyear,
		output wire cs, rd, wr, ad,
		output wire listoescritura, listolectura, listodireccion
	 );
	 
//declaracion de señales.

	wire izquierda;
	wire aumentar;
	wire disminuir;
	wire derecha;
	wire [7:0] countsecs;
	wire [7:0] countmins;
	wire [7:0] counthours;
	wire [7:0] countdays;
	wire [7:0] countmonths;
	wire [7:0] countyears;
	wire [7:0] countleftright;
	wire configformato;
	wire docehorasa;
	wire mandaunoa;
	wire rda;
	wire rdb;
	wire rdc;
	wire rdd;
	wire rde;
	wire rdf;
	wire rdg;
	wire rdh;
	wire enini;
	wire enwrite;
	wire enread;
	wire acs;
	wire awr;
	wire ard;
	wire aad;
	wire ecs;
	wire ewr;
	wire erd;
	wire ead;
	wire lcs;
	wire lwr;
	wire lrd;
	wire lad;
	wire enablee;
	wire enabled;
	wire enablel;
	
//instanciacion metaestabilidad.

//metaestabilidad boton izquierda.

	metaizquierda metaestabilidadizquierda (
		.boton_izquierda(boton_izquierda), 
		.clk(clk), 
		.izquierda(izquierda)
	);

//metaestabilidad boton derecha.

	metaderecha metaestabilidadderecha (
		.boton_derecha(boton_derecha),
		.clk(clk),
		.derecha(derecha)
	);

//metaestabilidad boton aumenta.

	metaaumentar metaestabilidadaumentar (
		.boton_aumenta(boton_aumenta),
		.clk(clk),
		.aumentar(aumentar)
	);

//metaestabilidad boton disminuye.

	metadisminuir metaestabilidaddisminuir (
		.boton_disminuye(boton_disminuye),
		.clk(clk),
		.disminuir(disminuir)
	);

//instanciacion contadores.

//contador segundos.

	countseconds csecs (
		.clk(clk), 
		.aumentar(aumentar), 
		.disminuir(disminuir), 
		.countsecs(countsecs)
	);

//contador minutos.

	countminutes cmins (
		.clk(clk),
		.aumentar(aumentar),
		.disminuir(disminuir),
		.countmins(countmins)
	);

//contador horas.

	counthours chours (
		.clk(clk),
		.aumentar(aumentar),
		.disminuir(disminuir),
		.counthours(counthours)
	);

//contador dias.

	countdays cdays (
		.clk(clk),
		.aumentar(aumentar),
		.disminuir(disminuir),
		.countdays(countdays)
	);

//contador meses.

	countmonths cmonths (
		.clk(clk),
		.aumentar(aumentar),
		.disminuir(disminuir),
		.countmonths(countmonths)
	);

//contador años.

	countyears cyears (
		.clk(clk),
		.aumentar(aumentar),
		.disminuir(disminuir),
		.countyears(countyears)
	);

//contador izquierda derecha.

	countleftright clr (
		.clk(clk),
		.izquierda(izquierda),
		.derecha(derecha),
		.countleftright(countleftright)
	);

//deco.

	decocontadores countdecoder (
		.countyears(countyears), 
		.countmonths(countmonths), 
		.countdays(countdays), 
		.counthours(counthours), 
		.countmins(countmins), 
		.countsecs(countsecs), 
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
		.ones(ones)
	);

//instanciacion control rtc

	controlrtc controldelrtc (
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
		.listo(listo), 
		.listoe(listoe),
		.listod(listod),
		.enablee(enablee), 
		.enabled(enabled), 
		.enablel(enablel), 
		.listolectura(listolectura), 
		.listoescritura(listoescritura),
		.listodireccion(listodireccion),
		.acs(acs), 
		.awr(awr), 
		.ard(ard), 
		.aad(aad), 
		.ecs(ecs), 
		.ewr(ewr), 
		.erd(erd), 
		.ead(ead), 
		.lcs(lcs), 
		.lwr(lwr), 
		.lrd(lrd), 
		.lad(lad), 
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

//instanciacion escribir leer

	escribirleer uut (
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
		.countleftright(countleftright), 
		.listolectura(listolectura), 
		.listoescritura(listoescritura),
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

//instanciacion modulo señales de control.

	controlsignalsrtc controlsignals (
		.clk(clk),
		.enablee(enablee), 
		.enabled(enabled), 
		.enablel(enablel), 
		.ecs(ecs), 
		.erd(erd), 
		.ewr(ewr), 
		.ead(ead), 
		.acs(acs), 
		.ard(ard), 
		.awr(awr), 
		.aad(aad), 
		.lcs(lcs), 
		.lrd(lrd), 
		.lwr(lwr), 
		.lad(lad), 
		.cs(cs), 
		.rd(rd), 
		.wr(wr), 
		.ad(ad)
	);

endmodule
