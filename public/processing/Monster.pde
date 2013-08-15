class MonsterModel{
	int positionX;
	int positionY;
	int monsterSize;
	string direction;
	int[] color;

	public MonsterModel(int positionX, int positionY, int monsterSize, int speed, string direction, int[] monsterColor){
		this.positionX = positionX;
		this.positionY = positionY;
		this.monsterSize = monsterSize;
		this.monsterColor = monsterColor;
		this.speed = speed;
		this.direction = direction;
	}

	public MonsterModel(){
		this.positionX = 0;
		this.positionY = 0;
		this.monsterSize = 0;
	}

	public int getPositionX(){
		return this.positionX;
	}
	public int getPositionY(){
		return this.positionY;
	}
	public int getMonsterSize(){
		return this.monsterSize;
	}
	public int getColor(){
		return this.color;
	}
	public int getDirection(){
		return this.direction;
	}

	public int getSpeed(){
		return this.speed;
	}

	public void setDirection(int[] direction){
		this.direction = direction;
	}

	public void setPositionX(int positionX){
		this.positionX = positionX;
	}
	public void setPositionY(int positionY){
		this.positionY = positionY;
	}
	public void setMonsterSize(int monsterSize){
		this.monsterSize = monsterSize;
	}
	public void setColor(int color){
		this.color = color;
	}
	public void setSpeed(int speed){
		this.speed = speed;
	}

};

class MonsterController{
	public MonsterController(MonsterModel monsterModel, MonsterGraphics monsterGraphics){
		this.monsterModel = monsterModel;
		this.monsterGraphics = monsterGraphics;

	}

	private void moveMonster(string keyInput){
		if (keyInput == 'UP'){
			this.monsterModel.setDirection('UP');
			// this.monsterGraphics.moveUp(this.monsterModel);
		}if (keyInput == 'DOWN'){
			this.monsterModel.setDirection('DOWN');
			// this.monsterGraphics.moveDown(this.monsterModel, previousDirection);
		}if (keyInput == 'LEFT'){
			this.monsterModel.setDirection('LEFT');
		}if (keyInput == 'RIGHT'){
			this.monsterModel.setDirection('RIGHT');
		}

	}

	public void driftMonster(){
		if (this.monsterModel.direction == 'UP'){
			this.monsterGraphics.moveUp(this.monsterModel);
		}if (this.monsterModel.direction == 'DOWN'){
			this.monsterGraphics.moveDown(this.monsterModel);
		}if (this.monsterModel.direction == 'LEFT'){
			this.monsterGraphics.moveLeft(this.monsterModel);
		}if (this.monsterModel.direction == 'RIGHT'){
			this.monsterGraphics.moveRight(this.monsterModel);
		}
	}
	public void draw(){
		this.driftMonster();
		this.monsterGraphics.draw(this.monsterModel);
	}
};

public interface Event{
	public boolean eventCondition(){}
	private void eventCallback(){}
}

class MonsterCollisionEvent implements Event{
	MonsterModel monsters;
	public MonsterCollisionEvent(MonsterModel monsters){
		this.monsters = monsters;
	}

	public boolean eventCondition(){
		for (Monster monsterOuter: this.monsters){
			for(Monster monsterInner: this.monsters){
				if (monsterOuter != monsterInner){
					if(this.computeCollision(monsterInner, monsterOuter) ){
						this.eventCallback(monsterInner, monsterOuter);
						break
					}
				}
			}
		}
	}

	private boolean computeCollision(monsterA, monsterB){
		xVector = Math.abs(monsterA.getPositionX() - monsterB.getPositionX());
		yVector = Math.abs(monsterA.getPositionY() - monsterB.getPositionY());
		distance = Math.pow(Math.pow(xVector,2)+Math.pow(yVector,2), .5);
		if (distance < (monsterA.getMonsterSize() + monsterB.getMonsterSize())){
			return true;
		}
	}

	private void eventCallback(){

	}
	private void eventCallback(monsterA, monsterB){
		if (monsterA.getMonsterSize() > monsterB.getMonsterSize()){
			// console.log('monster A: ' + monsterA.getMonsterSize());
			// console.log('monster B: ' + monsterB.getMonsterSize());
			monsterA.setMonsterSize(monsterA.getMonsterSize());
		}
		if (monsterA.getMonsterSize() < monsterB.getMonsterSize()){
			// console.log('monster A: ' + monsterA.getMonsterSize());
			// console.log('monster B: ' + monsterB.getMonsterSize());
			monsterA.setMonsterSize(0);
		}
	}
};

class WallCollisionEvent implements Event{
	MonsterModel monsters;
	public WallCollisionEvent(MonsterModel monsters){
		this.monsters = monsters;
	}

	public boolean eventCondition(){
		Integer collisionDistanceOffset = 15;
		for (Monster monster: this.monsters){
			if (monster.getPositionX() < 0 - collisionDistanceOffset){
				this.eventCallbackSidewall(monster, 'LEFT');
			}
			if (monster.getPositionX() > document.documentElement.clientWidth + collisionDistanceOffset){
				this.eventCallbackSidewall(monster, 'RIGHT');
			}
			if (monster.getPositionY() > document.documentElement.clientHeight + collisionDistanceOffset){
				this.eventCallbackSidewall(monster, 'DOWN');
			}
			if (monster.getPositionY() < 0 - collisionDistanceOffset){
				this.eventCallbackSidewall(monster, 'UP');
			}
		}
	}

	public void eventCallback(){
		console.log('overloaded method, see implementation with monster');
	}
	public void eventCallbackSidewall(Monster monster, string boundary){
		if (boundary == 'LEFT'){
			monster.setPositionX(document.documentElement.clientWidth);
		}

		if (boundary == 'RIGHT'){
			monster.setPositionX(0);
		}

		if (boundary == "UP"){
			monster.setPositionY(document.documentElement.clientHeight);
		}

		if (boundary == "DOWN"){
			monster.setPositionY(0);
		}
	}
};


class MonsterGraphics{
	public MonsterGraphics(){

	}
	public void draw(MonsterModel monsterModel){
		ellipse(monsterModel.positionX, monsterModel.positionY, monsterModel.monsterSize, monsterModel.monsterSize);
		fill(monsterModel.monsterColor[0], monsterModel.monsterColor[1], monsterModel.monsterColor[2]);
	}
	public void moveUp(MonsterModel monsterModel){
		monsterModel.setPositionY(monsterModel.getPositionY()-monsterModel.getSpeed());
	}
	public void moveDown(MonsterModel monsterModel){
		monsterModel.setPositionY(monsterModel.getPositionY()+monsterModel.getSpeed());
	}
	public void moveLeft(MonsterModel monsterModel){
		monsterModel.setPositionX(monsterModel.getPositionX()-monsterModel.getSpeed());
	}
	public void moveRight(MonsterModel monsterModel){
		monsterModel.setPositionX(monsterModel.getPositionX()+monsterModel.getSpeed());
	}

};


class MonsterIO{
	MonsterModel monsterController;
	public MonsterIO(MonsterModel monsterController){
		this.monsterController = monsterController;
	}

	private void moveKeyPress(){
		if (keyCode == UP){
			this.monsterController.moveMonster('UP');
			// this.monsterController.driftMonster();
		}

		if (keyCode == DOWN){
			this.monsterController.moveMonster('DOWN');
			// this.monsterController.driftMonster();
		}

		if (keyCode == LEFT){
			this.monsterController.moveMonster('LEFT');
			// this.monsterController.driftMonster();
		}

		if (keyCode == RIGHT){
			this.monsterController.moveMonster('RIGHT');
			// this.monsterController.driftMonster();
		}
	}


}