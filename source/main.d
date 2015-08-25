module main;

import std.conv;
import std.string;
import std.stdio;
import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;
import std.process;
import std.regex;
import std.algorithm;
import std.file;
import MeGlWindow;

GLFWwindow* initGLFWandMakeWindow()
{
  // Load GLFW3 (has to be loaded first)
  DerelictGLFW3.load();

  // Fail fast if glfw didn't initialize
  if (glfwInit() == 0) 
      throw new Exception("glfwInit failed");

  // Load GL3 (has to be loaded second)
  DerelictGL3.load();

  // Either create a small window
  //auto wind = glfwCreateWindow(600, 400, "Triangle", null, null); 

  // Or a full screen window
  auto wind = glfwCreateWindow(1440, 900, "OpenGL", glfwGetPrimaryMonitor(), null); // Fullscreen

  // If wind failed to create then indicate it
  if(!wind) 
      throw new Exception("Window Creation Failed.");

  // Set current gl context to wind
  glfwMakeContextCurrent(wind);

  // Needed to init
  DerelictGL3.reload();

  // Return our wind
  return(wind);
}

void main(string[] argv)
{
  GLFWwindow* winMain = initGLFWandMakeWindow();

  MeGlWindow mglw = new MeGlWindow;

  mglw.initializeGL();

  while (!glfwWindowShouldClose(winMain))    // Loop until the user closes the window
  {
    // Paint window
    mglw.paintGL(winMain);

    // Swap front and back buffers 
    glfwSwapBuffers(winMain);

    // Poll for and process events
    glfwPollEvents();
  }

  glfwTerminate();

  return;
}

