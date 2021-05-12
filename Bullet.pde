class Bullet{
    public int x;
    public int y;

    float speedX;
    float speedY;
    int preX;
    int preY;

    public int damage = 10;
    Bullet(int x, int y, float speedX, float speedY){
        this.x = x;
        this.y = y;
        this.speedX = speedX;
        this.speedY = speedY;
        preX = x;
        preY = y;

    }

    void move(){
        preX = x;
        preY = y;
        x += speedX;
        y += speedY;
    }
}