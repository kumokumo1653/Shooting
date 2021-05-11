Character c;
int t;
void setup(){
    size(1600,900);
    c = new Character(100, 100, 800, 450);
    t = 0;
}

void draw(){
    background(#000000);
    c.drawCharacter(t++);
}