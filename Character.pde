public class Character {
    public int maxHP;
    public int maxSP;

    int hp;
    int sp;

    public PVector pos;
    
    public PVector prePos;
    float speed = 8.0;
   
    ArrayList<Bullet> bullets = new ArrayList<Bullet>();
    Character(int HP, int SP, PVector pos){
        maxHP = HP;
        maxSP = SP;
        this.pos = new PVector(pos.x, pos.y);
        prePos = new PVector(pos.x, pos.y);
        hp = maxHP;
        sp = maxSP;
    }

    public void drawCharacter(int t){
        float a = 2 * PI / 50 * t;
        float b = -2 * PI / 100 * t;
        noStroke();
        fill(#ffffff);
        ellipse(pos.x, pos.y, 100, 100);
        strokeWeight(10);
        stroke(#ffcc00);
        noFill();
        arc(pos.x, pos.y, (float)130, (float)130, a, a + PI);
        arc(pos.x, pos.y, (float)160, (float)160, b, b + PI / 2);
    }

    public void drawStatus(){
        fill(#ffffff);
        textSize(20);
        text("HP", 10,15);
        strokeWeight(20);
        stroke(#ffffff);
        line(60,10, 60 + 200 / maxHP * hp, 10);

        text("SP", 10,40);
        line(60,40, 60 + 200 / maxSP * sp, 40);
    }


    public void move(PVector movemnt){
        prePos.set(pos.get());
        pos.x += movement.x * speed;
        pos.y += movemnt.y * speed;
    }

    public void shoot(){}
}
