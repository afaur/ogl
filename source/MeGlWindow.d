module MeGlWindow;

import derelict.opengl3.gl3;
import derelict.glfw3.glfw3;
import std.stdio;
import std.conv;
import MyToolBox;

class MeGlWindow
{

  void initializeGL()
  {

    // Clear the window color to black
    glClearColor(0.0, 0.0, 0.0, 1.0);

    // Hold an integer for our buffer
    GLuint myBufferID;

    // Set our vertex points
    GLfloat[] verts = [  0.0f,  1.0f,
                        -1.0f, -1.0f,
                         1.0f, -1.0f ];

    // Create a buffer and store the id of it in myBufferID
    glGenBuffers(1, &myBufferID);

    // Tell our buffer that it is a GL_ARRAY_BUFFER
    glBindBuffer(GL_ARRAY_BUFFER, myBufferID);

    int lengthOfElements = to!int(verts.length);
    int sizeInBytes = to!int(verts.arrayByteSize);

    // Give our buffer some data and explain how big it is
    glBufferData(GL_ARRAY_BUFFER, sizeInBytes, verts.ptr, GL_STATIC_DRAW);

    // Enable our data as type vertex
    glEnableVertexAttribArray(0);

    // Explain that our vertex data consists of 2 floats per vertex
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, cast(const(void)*) 0);

  }

  void paintGL(GLFWwindow* w)
  {
    // Reset the color bit
    glClear(GL_COLOR_BUFFER_BIT); 

    // Define holders for window width and height
    int width, height;

    // Get the current window width and height and store them
    glfwGetWindowSize(w, &width, &height);

    // Set the viewpoint as 0x 0y to width and height of window
    glViewport(0, 0, width, height); 

    // Draw triangle using three vertex points
    glDrawArrays(GL_TRIANGLES, 0, 3);

    // Pause
    writeAndPause("After glDrawArrays");
  }

}

