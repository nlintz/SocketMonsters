void setup(){
	frameRate(60);
	windowWidth = document.documentElement.clientWidth;
	windowHeight = document.documentElement.clientHeight;
	size(windowWidth, windowHeight);
	background(215, 218, 219);
	noStroke();
	smooth()


	// nm = new MonsterModel(windowWidth/2, windowHeight/2, 20, 2, 'RIGHT', [0, 66, 72]);
	// nm2 = new MonsterModel(windowWidth/2, windowHeight/2 + 100, 50, 2, 'LEFT', [250, 66, 72]);
	// nm3 = new MonsterModel(windowWidth/2 + 200, windowHeight/2 + 200, 50, 2, 'LEFT', [100, 0, 30]);

	// mg = new MonsterGraphics();
	// mc = new MonsterController(nm, mg);
	// mc2 = new MonsterController(nm2, mg);
	// mc3 = new MonsterController(nm3, mg);
	mcf = new MonsterControllerFactory();
	// console.log(mcf);
	mc = mcf.buildMonsterController();
	mc2 = mcf.buildRandomMonsterController();
	mc3 = mcf.buildRandomMonsterController();

	monsters = [mc.monsterModel, mc2.monsterModel, mc3.monsterModel];

	mio = new MonsterIO(mc);
	c = new MonsterCollisionEvent(monsters);
	w = new WallCollisionEvent(monsters);



}

void draw(){
	w.eventCondition();
	// c.eventCondition();
	background(215, 218, 219);
	mc.draw();
	mc2.draw();
	mc3.draw();

}

void keyPressed(){
	mio.moveKeyPress()
}