Character c;
int t;
int horizontal = 0;
int vertical = 0;
PVector movement = new PVector(0,0);
void setup(){
    size(1600,900);
    c = new Character(100, 100, new PVector(800, 450));
    t = 0;
}

void draw(){
    background(#000000);
    c.move(movement);
    c.drawCharacter(t++);
    c.drawStatus();

}

void keyPressed() {
    if(key == 'w')
        movement.y = -1;
    if(key == 's')
        movement.y = 1;
    if(key == 'a')
        movement.x = -1;
    if(key == 'd')
        movement.x = 1;
}

void keyReleased() {
    if(key == 'w')
        movement.y = 0;
    if(key == 's')
        movement.y = 0;
    if(key == 'a')
        movement.x = 0;
    if(key == 'd')
        movement.x = 0;
}