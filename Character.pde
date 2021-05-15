public class Character {
    public int maxHP;
    public int maxSP;

    int hp;
    int sp;
    int r = 100;
    int W;
    int H;
    public PVector pos;
    
    public PVector prePos;
    float speed = 8.0;
    float bulletSpeed = 20;
    ArrayList<Bullet> bullets = new ArrayList<Bullet>();
    Character(int HP, int SP, PVector pos, int W, int H){
        maxHP = HP;
        maxSP = SP;
        this.pos = new PVector(pos.x, pos.y);
        prePos = new PVector(pos.x, pos.y);
        hp = maxHP;
        sp = maxSP;

        this.W = W;
        this.H = H;
    }

    public void drawCharacter(int t){
        float a = 2 * PI / 50 * t;
        float b = -2 * PI / 100 * t;
        noStroke();
        fill(#ffffff);
        ellipse(pos.x, pos.y, r, r);
        strokeWeight(10);
        stroke(#ffcc00);
        noFill();
        arc(pos.x, pos.y, (float)r + 30, (float)r + 30, a, a + PI);
        arc(pos.x, pos.y, (float)r + 60, (float)r + 60, b, b + PI / 2);
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
        if(!collision()){
            pos.set(prePos.get());
        }
    }

    public boolean collision(){
        if(pos.x + r / 2 > W || pos.x - r / 2 < 0)
            return false;
        if(pos.y + r / 2 > H || pos.y - r / 2 < 0)
            return false;
        return true;
    }
    public void shoot(PVector target){
        PVector d = PVector.sub(target, pos);
        d.normalize();
        bullets.add(new Bullet(pos, PVector.mult(d, bulletSpeed)));
    }

    public void bulletsControl(){
        for(int i = 0; i < bullets.size(); i++){
            if(!bullets.get(i).move(W, H)){
                bullets.remove(i);
                i--;
            }else{
                bullets.get(i).drawBullet();
            }
        }
    }
}
