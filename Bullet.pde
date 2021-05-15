class Bullet{
    public PVector pos;

    PVector speed;
    PVector prePos;
    int r = 20;
    public int damage = 10; 
    Bullet(PVector pos, PVector speed){
        this.pos = new PVector(pos.x, pos.y);
        this.speed = new PVector(speed.x, speed.y);
        prePos = new PVector(pos.x, pos.y);

    }

    void drawBullet(){
        noStroke();
        fill(#ffffff);
        ellipse(pos.x, pos.y, r, r);
    }
    boolean move(int W, int H){
        prePos.set(pos.get());
        pos.x += speed.x;
        pos.y += speed.y;
        if(pos.x - r / 2 > W || pos.x + r / 2 < 0)
            return false;
        if(pos.y - r/ 2 > H || pos.y + r / 2 < 0)
            return false;
        return true;
    }
}