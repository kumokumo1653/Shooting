Character c;
int t;
int horizontal = 0;
int vertical = 0;
void setup(){
    size(1600,900);
    c = new Character(100, 100, 800, 450);
    t = 0;
}

void draw(){
    background(#000000);
    c.move(horizontal, vertical);
    c.drawCharacter(t++);
    c.drawStatus();

}

void keyPressed() {
    if(key == 'w')
        vertical = -1;
    if(key == 's')
        vertical = 1;
    if(key == 'a')
        horizontal = -1;
    if(key == 'd')
        horizontal = 1;
}

void keyReleased() {
    if(key == 'w')
        vertical = 0;
    if(key == 's')
        vertical = 0;
    if(key == 'a')
        horizontal = 0;
    if(key == 'd')
        horizontal = 0;
}