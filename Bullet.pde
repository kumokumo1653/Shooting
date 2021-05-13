class Bullet{
    public PVector pos;

    PVector speed;
    PVector prePos;

    public int damage = 10; 
    Bullet(PVector pos, PVector speed){
        this.pos = new PVector(pos.x, pos.y);
        this.speed = new PVector(speed.x, speed.y);
        prePos = new PVector(pos.x, pos.y);

    }

    void move(){
        prePos.set(pos.get());
        pos.x += speed.x;
        pos.y += speed.y;
    }
}