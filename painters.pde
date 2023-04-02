/**
 Program that uses a Binary Space Partitioning tree to 
 showcase the Painter's Algorithm
 
 Controls:
  * Mouse over a color in the palette to the right to change color
  * Click twice to draw a line segment
  * Right click to draw 360 degree view based on Painter's Algorithm
   - Can hold and drag to move view
  * Type p to print your BSP to console
  * Type v to validate your BSP (outputs to console)
 */

BSPTree bsp;
Palette p;
PVector v;
color c;

void setup()
{
  size(640, 480);
  background(255);
  bsp = new BSPTree();
  p = new Palette();
  v = null;
  strokeWeight(2);
  c = color(0,0,0);
  stroke(c);
}

void draw() 
{
  background(255);
  p.draw();
  c = p.getColor(mouseX, mouseY, c);
  bsp.draw();
  if (mouseButton == RIGHT)
    bsp.painters(new PVector(mouseX, mouseY));
}

void mouseClicked()
{
  if (mouseButton == LEFT)
  {
    if (v == null)
      v = new PVector(mouseX, mouseY);
    else
    {
      Segment s = new Segment(v.x, v.y, mouseX, mouseY, c);
      bsp.insert(s);
      v = null;
    }
  }
}

void keyTyped()
{
  if (key == 'p')
    println(bsp);
  else if (key == 'v')
    if (bsp.validate())
      println("BSP is valid!");
}
