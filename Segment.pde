/**
  Class representing a line segment
  Segments are defined by a start point and an endpoint,
  which can be given in either order
 */
public class Segment
{
  public static final float VIEW_RADIUS = 30f;
  
  private PVector p, q;
  private color c;
  
  /**
   Create a black segment, (0, 0) to (0, 0)
   */
  public Segment()
  {
    p = new PVector(0, 0);
    q = new PVector(0, 0);
    c = color(0, 0, 0);
  }
  /**
   Create a segment based on the x and y coordinates of 
   it start and end points
   */
  public Segment(float startX, float startY, float endX, float endY, color col)
  {
    p = new PVector(startX, startY);
    q = new PVector(endX, endY);
    c = col;
  }

  /**
   Draws the line segment on the canvas
   */
  public void draw()
  {
    stroke(c);
    line(p.x, p.y, q.x, q.y);
  }
  
  /**
   Prints out the segment in the form start:end
   */
  public String toString()
  {
    return p + ":" + q;
  }

  /**
   Returns the intersection of this segment and the line containing the
   given segment
   Returns null if this segment doesn't intersect the line, or if this
   segment is parallel or colinear with the argument
   */
  public PVector intersect(Segment s2)
  {
    PVector delta = s2.p.copy().sub(p);
    PVector m1 = q.copy().sub(p);
    PVector m2 = s2.q.copy().sub(s2.p);
    float denom = m1.x * m2.y - m1.y * m2.x;
    if (abs(denom) < EPSILON)
      return null;
    else
    {
      float t1 = -(m2.x * delta.y - m2.y * delta.x) / denom;
      if (t1 >= -EPSILON && t1 <= 1f + EPSILON)
        return m1.mult(t1).add(p);
      else
        return null;
    }
  }
  
  /**
   Functions to return whether the given point is to the left of,
   to the right of, or colinear with this Segment
   */
  public boolean isToLeft(PVector v)
  {
    PVector temp = v.copy().sub(p).cross(q.copy().sub(p));
    return temp.z < -1f;
  }
  public boolean isToRight(PVector v)
  {
    PVector temp = v.copy().sub(p).cross(q.copy().sub(p));
    return temp.z > 1f;
  }
  public boolean isInline(PVector v)
  {
    PVector temp = v.copy().sub(p).cross(q.copy().sub(p));
    return abs(temp.z) <= 1f;
  }

  /**
   Helper functions that return whether the given segment is to the
   left or right of this line
   */
  public boolean isToLeft(Segment s)
  {
    return isToLeft(s.p);
  }
  public boolean isRight(Segment s)
  {
    return isToRight(s.p);
  }

  /**
   Helper function for building a Binary Space Partitioning tree
   If this segment intersects the line containing the argument,
   this function splits the current segment in two at the intersection
   point.  
   
   The endpoint of this segment becomes the intersection point,
   and the returned segment is oriented towards the intersection
   */
  public Segment split(Segment sp)
  {
    PVector i = intersect(sp);
    if (i == null)
      return null;
    else
    {
      Segment ret = new Segment(q.x, q.y, i.x, i.y, c);
      q = i;
  
      return ret;
    }
  }

  /**
   Draws an arc at the given point representing the view of
   this Segment from that point
   */
  public void paintView(PVector origin)
  {
    float start = atan2(p.y - origin.y, p.x - origin.x);
    float end = atan2(q.y - origin.y, q.x - origin.x);
    if (end < start)
    {
      float temp = start;
      start = end;
      end = temp;
    }
    if (end - start > PI)
    {
      float temp = start + TWO_PI;
      start = end;
      end = temp;
    }

    noStroke();
    fill(c);
    arc(origin.x, origin.y, VIEW_RADIUS, VIEW_RADIUS, start, end);
    noFill();
  }
}
