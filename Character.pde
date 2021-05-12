public class Character {
    public int maxHP;
    public int maxSP;

    int hp;
    int sp;

    public int x;
    public int y;
    
    int preX;
    int preY;

    float speed = 4.0;

    Character(int HP, int SP, int x, int y){
        maxHP = HP;
        maxSP = SP;
        this.x = x;
        this.y = y;
        preX = x;
        preY = y;
        hp = maxHP;
        sp = maxSP;
    }

    public void drawCharacter(int t){
        float a = 2 * PI / 50 * t;
        float b = -2 * PI / 100 * t;
        noStroke();
        fill(#ffffff);
        ellipse(x, y, 200, 200);
        strokeWeight(10);
        stroke(#ffcc00);
        noFill();
        arc((float)x, (float)y, (float)230, (float)230, a, a + PI);
        arc((float)x, (float)y, (float)260, (float)260, b, b + PI / 2);
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


    public void move(int hMovement, int vMovemnt){
        preX = x;
        preY = y;
        x += hMovement * speed;
        y += vMovemnt * speed;
    }
}
