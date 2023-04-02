public class Palette
{
  public static final float XMIN = 610f;
  public static final float YMIN = 40f;
  public static final float WIDTH = 20f;
  public static final float HEIGHT = 20f;
  public static final float GAP = 40f;
  public color[] COLORS = {#000000, #ff0000, #c0c000, #00ff00, #00c0c0, #0000ff, #c000c0};

  public Palette() {}
  
  public void draw()
  {
    stroke(0);
    strokeWeight(1f);
    for (int i = 0; i < COLORS.length; i++)
    {
      fill(COLORS[i]);
      rect(XMIN, YMIN + i * (HEIGHT + GAP), WIDTH, HEIGHT);
    }
  }
  
  public color getColor(float x, float y, color c)
  {
    int i = (int) ((y - YMIN + EPSILON) / (HEIGHT + GAP));
    int j = (int) ((y - YMIN + EPSILON) % (HEIGHT + GAP));
    if (i >= 0 && i < COLORS.length && j <= HEIGHT + EPSILON 
     && x >= XMIN - EPSILON && x <= XMIN + WIDTH + EPSILON)
      return COLORS[i];
    else
      return c;
  }
}
