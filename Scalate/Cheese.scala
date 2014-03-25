package net.cosmo0920
import org.fusesource.scalate.RenderContext.capture
object Cheese {
  def foo(productId: Int) =
    <a href={"/products/" + productId} title="link">Product</a>
}
