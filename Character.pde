public class Character {
    public int maxHP;
    public int maxSP;

    int hp;
    int sp;
    public int r = 100;
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
        if(hp > 0)
            line(60,10, 60 + 200 / maxHP * hp, 10);

        text("SP", 10,40);
        if(sp > 0){
            line(60,40, 60 + 200 / maxSP * sp, 40);
        }
    }


    public void move(PVector movement){
        prePos.set(pos.get());
        pos.x += movement.x * speed;
        pos.y += movement.y * speed;
    }

    public boolean collision(Character enemy){
        boolean val = true;
        if(pos.x + r / 2 > W || pos.x - r / 2 < 0){
            pos.set(prePos.get());
            val = false;
        }
        if(pos.y + r / 2 > H || pos.y - r / 2 < 0){
            pos.set(prePos.get());
            val = false;
        }
        
        //敵との衝突
        if(PVector.dist(pos, enemy.pos) <= r / 2 + enemy.r / 2){

            pos.set(prePos.get());
            enemy.pos.set(enemy.prePos.get());
            val = false;
        }
        
        //敵の弾との衝突
        for (int i = 0; i < enemy.bullets.size(); i++){
            if(PVector.dist(pos, enemy.bullets.get(i).pos) <= r / 2 + enemy.bullets.get(i).r / 2){
                println("shot");
                enemy.bullets.remove(i);
                i--;
                hp -= 10;
                println(hp);
                val = false;
            }
        }

        //自分の球の衝突
        for (int i = 0; i < this.bullets.size(); i++){
            if(PVector.dist(enemy.pos, this.bullets.get(i).pos) <= enemy.r / 2 + this.bullets.get(i).r / 2){
                println("hit");
                bullets.remove(i);
                i--;
                val = false;
            }
        }

        return val;
    }
    public void shoot(PVector target){

        if(sp >= 10){
            PVector d = PVector.sub(target, pos);
            d.normalize();
            bullets.add(new Bullet(pos, PVector.mult(d, bulletSpeed)));
            sp -= 10;
            println(sp);
        }
    }

    public void bulletsControl(){
        for(int i = 0; i < bullets.size(); i++){
            if(!bullets.get(i).move(W, H)){
                bullets.remove(i);
                i--;
            }
        }
    }

    public void drawBullets(){
        for(int i = 0; i < bullets.size(); i++)
            bullets.get(i).drawBullet();
        
    }
}
