public class Character {
    public int HP;
    public int SP;

    public int x;
    public int y;

    Character(int HP, int SP, int x, int y){
        this.HP = HP;
        this.SP = SP;
        this.x = x;
        this.y = y;
    }

    public void drawCharacter(int t){
        float theta = 2 * PI / 50 * t;
        noStroke();
        fill(#ffffff);
        ellipse(x, y, 200, 200);
        strokeWeight(10);
        stroke(#ffcc00);
        noFill();
        arc((float)x, (float)y, (float)200, (float)200, theta, theta + PI);
    }
}
