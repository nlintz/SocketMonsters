class GameController{
	public GameController(){
		this.monsterModel = new MonsterModel(windowWidth/2, windowHeight/2, 20, 2, 'RIGHT', [0, 66, 72]);
		console.log(this.monsterModel);
	}
};

class MonsterControllerFactory{
	// MonsterFactory Class Creates MonsterControllers
	MonsterGraphics monsterGraphics = new MonsterGraphics();
	public class MonsterFactory(){
		this.monsterGraphics = monsterGraphics;
	}

	public MonsterController buildMonsterController(){
		MonsterModel monsterModel = new MonsterModel(windowWidth/2, windowHeight/2, 20, 2, 'RIGHT', [0, 0, 0]);
		MonsterController monsterController = new MonsterController(monsterModel, this.monsterGraphics);
		return monsterController;
	}

	public MonsterController buildRandomMonsterController(){
			Integer x = Math.floor(Math.random()*windowWidth/2);
			Integer y = Math.floor(Math.random()*windowHeight/2);
			Integer monsterSize = Math.floor(Math.random()*200);

			Integer[] monsterColor = [Math.floor(Math.random()*255), Math.floor(Math.random()*255), Math.floor(Math.random()*255)];

			console.log(monsterColor);
			MonsterModel monsterModel = new MonsterModel(x, y, monsterSize, 2, 'RIGHT', monsterColor);
			MonsterController monsterController = new MonsterController(monsterModel, this.monsterGraphics);
				return monsterController;
	}
};