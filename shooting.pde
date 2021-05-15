Character c;
int t;
int horizontal = 0;
int vertical = 0;
PVector movement = new PVector(0,0);
int W = 1600;
int H = 900;
boolean shoot = false;

void settings(){
    size(W, H);
}
void setup(){

    c = new Character(100, 100, new PVector(800, 450), W, H);
    t = 0;
    
}

void draw(){
    background(#000000);
    c.move(movement);
    c.drawCharacter(t++);
    c.drawStatus();
    if(shoot){
        shoot = false;
        c.shoot(new PVector(mouseX, mouseY));
    }
    c.bulletsControl();
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

void mousePressed() {
    if(mouseButton == LEFT){
        shoot = true;
    }
}