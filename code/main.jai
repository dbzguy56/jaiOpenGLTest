#import "Basic";
#import "GL";
#import "System";
#import "Window_Creation";
#import "File";
#import "String";
#import "Input";
#import "Math";
#import "stb_image";

Simp :: #import "Simp";

light_vbo : u32;
cube_vao : u32;
cube_vbo : u32;
light_vao : u32;
ebo : u32;
texture : u32;
texture2 : u32;
container_texture : u32;
vertices :: float32.[
    // positions          // colors           // texture coords
     0.5,  0.5, 0.0,   1.0, 0.0, 0.0,   1.0, 1.0,   // top right
     0.5, -0.5, 0.0,   0.0, 1.0, 0.0,   1.0, 0.0,   // bottom right
    -0.5, -0.5, 0.0,   0.0, 0.0, 1.0,   0.0, 0.0,   // bottom left
    -0.5,  0.5, 0.0,   1.0, 1.0, 0.0,   0.0, 1.0    // top left
    ];

cube_vertices :: float32 .[
    // positions          // normals     // texture coords
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  0.0, 0.0,
     0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  1.0, 0.0,
     0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  1.0, 1.0,
     0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  1.0, 1.0,
    -0.5,  0.5, -0.5,  0.0,  0.0, -1.0,  0.0, 1.0,
    -0.5, -0.5, -0.5,  0.0,  0.0, -1.0,  0.0, 0.0,

    -0.5, -0.5,  0.5,  0.0,  0.0, 1.0,   0.0, 0.0,
     0.5, -0.5,  0.5,  0.0,  0.0, 1.0,   1.0, 0.0,
     0.5,  0.5,  0.5,  0.0,  0.0, 1.0,   1.0, 1.0,
     0.5,  0.5,  0.5,  0.0,  0.0, 1.0,   1.0, 1.0,
    -0.5,  0.5,  0.5,  0.0,  0.0, 1.0,   0.0, 1.0,
    -0.5, -0.5,  0.5,  0.0,  0.0, 1.0,   0.0, 0.0,

    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,  1.0, 0.0,
    -0.5,  0.5, -0.5, -1.0,  0.0,  0.0,  1.0, 1.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,  0.0, 1.0,
    -0.5, -0.5, -0.5, -1.0,  0.0,  0.0,  0.0, 1.0,
    -0.5, -0.5,  0.5, -1.0,  0.0,  0.0,  0.0, 0.0,
    -0.5,  0.5,  0.5, -1.0,  0.0,  0.0,  1.0, 0.0,

     0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0, 0.0,
     0.5,  0.5, -0.5,  1.0,  0.0,  0.0,  1.0, 1.0,
     0.5, -0.5, -0.5,  1.0,  0.0,  0.0,  0.0, 1.0,
     0.5, -0.5, -0.5,  1.0,  0.0,  0.0,  0.0, 1.0,
     0.5, -0.5,  0.5,  1.0,  0.0,  0.0,  0.0, 0.0,
     0.5,  0.5,  0.5,  1.0,  0.0,  0.0,  1.0, 0.0,

    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  0.0, 1.0,
     0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  1.0, 1.0,
     0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  1.0, 0.0,
     0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  1.0, 0.0,
    -0.5, -0.5,  0.5,  0.0, -1.0,  0.0,  0.0, 0.0,
    -0.5, -0.5, -0.5,  0.0, -1.0,  0.0,  0.0, 1.0,

    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  0.0, 1.0,
     0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  1.0, 1.0,
     0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  1.0, 0.0,
     0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  1.0, 0.0,
    -0.5,  0.5,  0.5,  0.0,  1.0,  0.0,  0.0, 0.0,
    -0.5,  0.5, -0.5,  0.0,  1.0,  0.0,  0.0, 1.0
];

cube_positions :: Vector3.[
    Vector3.{0.0,  0.0,  0.0},
    Vector3.{2.0,  5.0, -15.0},
    Vector3.{-1.5, -2.2, -2.5},
    Vector3.{-3.8, -2.0, -12.3},
    Vector3.{2.4, -0.4, -3.5},
    Vector3.{-1.7,  3.0, -7.5},
    Vector3.{1.3, -2.0, -2.5},
    Vector3.{1.5,  2.0, -2.5},
    Vector3.{1.5,  0.2, -1.5},
    Vector3.{-1.3,  1.0, -1.5}
];

pointLightPositions :: Vector3.[
    .{0.7,  0.2,  2.0},
    .{2.3, -3.3, -4.0},
    .{-4.0,  2.0, -12.0},
    .{0.0,  0.0, -3.0}
];

pointLightColors :: Vector3.[
    .{0.8,  0.5,  0.2},
    .{0.2, 0.0, 0.0},
    .{0.8,  0.0, 0.0},
    .{0.7,  0.4, 0.4}
];

indices :: u32.[
    0, 1, 3,   // first triangle
    1, 2, 3    // second triangle
    ];
/*
texCoords :: float32.[
    0.0, 0.0,  // lower-left corner
    1.0, 0.0,  // lower-right corner
    0.5, 1.0   // top-center corner
];
*/
main :: () {
    init_time();

    set_working_directory(path_strip_filename(get_path_of_running_executable()));
    window := create_window(1920, 1080, "openglTest");
    Simp.set_render_target(window);
    incremented_color := 0.0;

    vertexShader := glCreateShader(GL_VERTEX_SHADER);
    vertexShaderSource := VERTEX_SHADER;
    vertexShaderCount := cast(s32) vertexShaderSource.count;
    glShaderSource(vertexShader, 1, *vertexShaderSource.data, *vertexShaderCount);
    glCompileShader(vertexShader);
    success: GLint;
    glGetShaderiv(vertexShader, GL_COMPILE_STATUS, *success);
    if success == 0 {
        len: GLint;
        glGetShaderiv(vertexShader, GL_INFO_LOG_LENGTH, *len);
        buf := cast(*u8) alloc(len);
        glGetShaderInfoLog(vertexShader, xx len, xx *len, buf);
        print("ERROR: %\n", to_string(buf));
        free(buf);

        glDeleteShader(vertexShader);
    }

    fragmentShader := glCreateShader(GL_FRAGMENT_SHADER);
    fragmentShaderSource := FRAGMENT_SHADER;
    fragmentShaderCount := cast(s32) fragmentShaderSource.count;
    glShaderSource(fragmentShader, 1, *fragmentShaderSource.data, *fragmentShaderCount);
    glCompileShader(fragmentShader);
    successDeux: GLint;
    glGetShaderiv(fragmentShader, GL_COMPILE_STATUS, *successDeux);
    if successDeux == 0 {
        len: GLint;
        glGetShaderiv(fragmentShader, GL_INFO_LOG_LENGTH, *len);
        buf := cast(*u8) alloc(len);
        glGetShaderInfoLog(fragmentShader, xx len, xx *len, buf);
        print("ERROR2: %\n", to_string(buf));
        free(buf);

        glDeleteShader(fragmentShader);
    }

    shaderProgram := glCreateProgram();
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);
    glLinkProgram(shaderProgram);
    successCinq: GLint;
    glGetProgramiv(shaderProgram, GL_LINK_STATUS, *successCinq);
    if successCinq == 0 {
        len: GLint;
        glGetProgramiv(shaderProgram, GL_INFO_LOG_LENGTH, *len);
        buf := cast(*u8) alloc(len);
        defer free(buf);
        glGetProgramInfoLog(shaderProgram, xx len, xx *len, buf);
        print("ERROR3: %\n", to_string(buf));

        glDeleteShader(shaderProgram);
        glDeleteShader(vertexShader);
        glDeleteShader(fragmentShader);
    }


    lightingVertexShader := glCreateShader(GL_VERTEX_SHADER);
    lightingVertexShaderSource := LIGHTING_VERTEX_SHADER;
    lightingVertexShaderCount := cast(s32) lightingVertexShaderSource.count;
    glShaderSource(lightingVertexShader, 1, *lightingVertexShaderSource.data, *lightingVertexShaderCount);
    glCompileShader(lightingVertexShader);
    successEight: GLint;
    glGetShaderiv(lightingVertexShader, GL_COMPILE_STATUS, *successEight);
    if successEight == 0 {
        len: GLint;
        glGetShaderiv(lightingVertexShader, GL_INFO_LOG_LENGTH, *len);
        buf := cast(*u8) alloc(len);
        glGetShaderInfoLog(lightingVertexShader, xx len, xx *len, buf);
        print("ERROR8: %\n", to_string(buf));
        free(buf);

        glDeleteShader(lightingVertexShader);
    }

    lightingShader := glCreateShader(GL_FRAGMENT_SHADER);
    lightingShaderSource := LIGHTING_FRAGMENT_SHADER;
    lightingShaderCount := cast(s32) lightingShaderSource.count;
    glShaderSource(lightingShader, 1, *lightingShaderSource.data, *lightingShaderCount);
    glCompileShader(lightingShader);
    successSix: GLint;
    glGetShaderiv(lightingShader, GL_COMPILE_STATUS, *successSix);
    if successSix == 0 {
        len: GLint;
        glGetShaderiv(lightingShader, GL_INFO_LOG_LENGTH, *len);
        buf := cast(*u8) alloc(len);
        glGetShaderInfoLog(lightingShader, xx len, xx *len, buf);
        print("ERROR6: %\n", to_string(buf));
        free(buf);

        glDeleteShader(lightingShader);
    }

    lightingShaderProgram := glCreateProgram();
    //glAttachShader(lightingShaderProgram, lightingVertexShader);*/
    glAttachShader(lightingShaderProgram, lightingVertexShader);
    glAttachShader(lightingShaderProgram, lightingShader);
    glLinkProgram(lightingShaderProgram);
    successSeven: GLint;
    glGetProgramiv(lightingShaderProgram, GL_LINK_STATUS, *successSeven);
    if successSeven == 0 {
        len: GLint;
        glGetProgramiv(lightingShaderProgram, GL_INFO_LOG_LENGTH, *len);
        buf := cast(*u8) alloc(len);
        defer free(buf);
        glGetProgramInfoLog(lightingShaderProgram, xx len, xx *len, buf);
        print("ERROR7: %\n", to_string(buf));

        glDeleteShader(lightingShaderProgram);
//        glDeleteShader(lightingVertexShader);
        glDeleteShader(lightingVertexShader);
        glDeleteShader(lightingShader);
    }

    glGenVertexArrays(1,*light_vao);
    glGenBuffers(1, *light_vbo);
    //glGenBuffers(1, *ebo);

    glBindBuffer(GL_ARRAY_BUFFER, light_vbo);
    glBufferData(GL_ARRAY_BUFFER, cube_vertices.count * size_of(float32), cube_vertices.data, GL_STATIC_DRAW);

    glBindVertexArray(light_vao);
    //glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, ebo);
    //glBufferData(GL_ELEMENT_ARRAY_BUFFER, indices.count * size_of(u32), indices.data, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 3, GL_FLOAT, false, 8 * size_of(float), null);
    glEnableVertexAttribArray(0);

    //glVertexAttribPointer(1, 3, GL_FLOAT, false, 6 * size_of(float), xx (3 * size_of(float)));
    //glEnableVertexAttribArray(1);

    //glVertexAttribPointer(2, 2, GL_FLOAT, false, 8 * size_of(float), xx (6 * size_of(float)));
    //glEnableVertexAttribArray(2);
    //glBindVertexArray(0);
    //glBindBuffer(GL_ARRAY_BUFFER, 0);*/

    //container_texture := create_texture("beegYoshi.png");
    container_texture := create_texture("container2.png");
    container_specular_texture := create_texture("container2_specular.png");
    //container_emission_texture := create_texture("container2_emission.jpg");

    glGenVertexArrays(1, *cube_vao);
    glGenBuffers(1, *cube_vbo);
    glBindVertexArray(cube_vao);
    glBindBuffer(GL_ARRAY_BUFFER, cube_vbo);
    glBufferData(GL_ARRAY_BUFFER, cube_vertices.count * size_of(float32), cube_vertices.data, GL_STATIC_DRAW);

    glVertexAttribPointer(0, 3, GL_FLOAT, false, 8 * size_of(float), null);
    glEnableVertexAttribArray(0);
    glVertexAttribPointer(1, 3, GL_FLOAT, false, 8 * size_of(float), xx (3 * size_of(float)));
    glEnableVertexAttribArray(1);
    glVertexAttribPointer(2, 2, GL_FLOAT, false, 8 * size_of(float), xx (6 * size_of(float)));
    glEnableVertexAttribArray(2);

    glUseProgram(lightingShaderProgram);
    material_diffuse_loc := glGetUniformLocation(lightingShaderProgram, "material.diffuse");
    glUniform1i(material_diffuse_loc, 0);
    material_specular_loc := glGetUniformLocation(lightingShaderProgram, "material.specular");
    glUniform1i(material_specular_loc, 1);
    //emission_map_loc := glGetUniformLocation(lightingShaderProgram, "emissionMap");
    //glUniform1i(emission_map_loc, 2);
    //glUniform1i(glGetUniformLocation(shaderProgram, "ourTexture"), 0);
    //glUniform1i(glGetUniformLocation(shaderProgram, "textureDeux"), 1);

    camera_pos := xyz(0.0, 0.0, 3.0);
    camera_front := xyz(0.0, 0.0, -1.0);
    camera_up := xyz(0.0, 1.0, 0.0);
    delta_time := 0.0;
    last_frame := 0.0;
    pitch := 0.0;
    yaw := -90.0;
    roll := 0.0;
    sensitivity := 0.1;
    fov := 45.0;

    point_light_positions : [4]Vector3 = Vector3.[
          Vector3.{0.7, 0.2, 2.0}
        , Vector3.{2.3, -3.3, -4.0}
        , Vector3.{-4.0, 2.0, -12.0}
        , Vector3.{0.0, 0.0, -3.0}
    ];

    running := true;
    while running
    {
        reset_temporary_storage();
        update_window_events();

        for events_this_frame {
            if it.type == .QUIT then running = false;
            if it.type == .KEYBOARD && it.key_pressed && it.key_code == .BACKSPACE then running = false;
        }

        current_frame : float32 = xx get_time();
        delta_time = current_frame - last_frame;
        last_frame = current_frame;
        camera_speed := 5 * delta_time;

        if input_button_states[#char "W"] & .DOWN {
            camera_pos += camera_speed * camera_front;
        }
        if input_button_states[#char "S"] & .DOWN {
            camera_pos -= camera_speed * camera_front;
        }
        if input_button_states[#char "A"] & .DOWN {
            camera_pos -= normalize_or_z_axis(cross(camera_front, camera_up)) * camera_speed;
        }
        if input_button_states[#char "D"] & .DOWN {
            camera_pos += normalize_or_z_axis(cross(camera_front, camera_up)) * camera_speed;
        }

        if mouse_delta_z > 0 {
           fov -= 1;
        }
        if mouse_delta_z < 0 {
           fov += 1;
        }

        if fov < 1.0 {
            fov = 1.0;
        }
        if fov > 45.0 {
            fov = 45.0;
        }

        y_offset := mouse_delta_y * sensitivity;
        x_offset := mouse_delta_x * sensitivity;

        yaw += x_offset;
        pitch -= y_offset;

        if pitch > 89.0 {
            pitch = 89.0;
        }
        if pitch < -89.0 {
            pitch = -89.0;
        }

        direction_x := cos(deg_to_rad(yaw) * cos(deg_to_rad(pitch)));
        direction_y := sin(deg_to_rad(pitch));
        direction_z := sin(deg_to_rad(yaw) * cos(deg_to_rad(pitch)));
        camera_front = normalize_or_z_axis(xyz(direction_x, direction_y, direction_z));

        glEnable(GL_DEPTH_TEST);
        glClearColor(0.0, 0.0, 0.0, 1.0);
        //glClearColor(0.2, 0.3, 0.3, 1.0);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        // actual source of light
        glUseProgram(shaderProgram);

        //x_pos := 1.0 + sin(get_time()) * 2.0;
        //z_pos := 1.0 + cos(get_time());
        //light_pos :=  xyz( xx x_pos, 0.5, xx z_pos);
        /*
        light_color := xyz(
              xx sin(get_time() * 2.0)
            , xx sin(get_time() * 0.7)
            , xx sin(get_time() * 1.3)
        );*/
        light_pos :=  xyz(1.2, 1.0, 2.0);
        light_color := xyz(0.0, 0.0, 0.0);
        //light_direction := xyz(-0.2, -1.0, -0.3);

        //m_trans := make_translation_matrix4(xyz(0.5, -0.5, 0.0));
        /*
        q : Quaternion;
        set_from_axis_and_angle(*q, 0.5, 1.0, 1.0, deg_to_rad(xx (get_time() * 50)));
        m_rotate := rotation_matrix(Matrix4, q);

        //m_scale := make_scale_matrix4(xyz(0.5, 0.5, 0.5));
        model_matrix := m_rotate; // m_trans * m_rotate * m_scale;
        model_loc := glGetUniformLocation(shaderProgram, "model");
        glUniformMatrix4fv(model_loc, 1, GL_TRUE, model_matrix.floats.data);
        */

        view_matrix := make_look_at_matrix( camera_pos
                                          , camera_pos + camera_front
                                          , camera_up
                                          , false);
        //view_matrix := make_translation_matrix4(xyz(0, 0, -3));
        view_loc := glGetUniformLocation(shaderProgram, "view");
        glUniformMatrix4fv(view_loc, 1, GL_TRUE, view_matrix.floats.data);

        projection_matrix := make_projection_matrix(deg_to_rad(fov)
                                                    , 1920.0 / 1080.0
                                                    , 0.1
                                                    , 100.0);
        projection_loc := glGetUniformLocation(shaderProgram, "projection");
        glUniformMatrix4fv(projection_loc, 1, GL_TRUE, projection_matrix.floats.data);

        //visibilityLocation := glGetUniformLocation(shaderProgram, "visibility");
        //glUniform1f(visibilityLocation, 0.2);

        light_source_color_loc := glGetUniformLocation(shaderProgram, "lightColor");
        //glUniform3f(light_source_color_loc, light_color.x, light_color.y, light_color.z);

        model_loc := glGetUniformLocation(shaderProgram, "model");
        glBindVertexArray(light_vao);

        for 0..3 {
            glUniform3f(light_source_color_loc, pointLightColors[it].x, pointLightColors[it].y, pointLightColors[it].z);

            m_trans := make_translation_matrix4(point_light_positions[it]);
            scale_factor := 0.2;
            m_scaled := make_scale_matrix4(xyz(scale_factor, scale_factor, scale_factor));
            m_result := m_trans * m_scaled;
            glUniformMatrix4fv(model_loc, 1, GL_TRUE, m_result.floats.data);
            glDrawArrays(GL_TRIANGLES, 0, 36);
        }


        // for cube affected by light
        glUseProgram(lightingShaderProgram);

        view_loc2 := glGetUniformLocation(lightingShaderProgram, "view");
        glUniformMatrix4fv(view_loc2, 1, GL_TRUE, view_matrix.floats.data);
        projection_loc2 := glGetUniformLocation(lightingShaderProgram, "projection");
        glUniformMatrix4fv(projection_loc2, 1, GL_TRUE, projection_matrix.floats.data);
        model_loc2 := glGetUniformLocation(lightingShaderProgram, "model");

        setVec3(lightingShaderProgram, "viewPos", camera_pos.x, camera_pos.y, camera_pos.z);
        setFloat(lightingShaderProgram, "material.shininess", 32.0);

        // directional light
        setVec3(lightingShaderProgram, "dirLight.direction", -0.2, -1.0, -0.3);
        setVec3(lightingShaderProgram, "dirLight.ambient", 0.05, 0.05, 0.05);
        setVec3(lightingShaderProgram, "dirLight.diffuse", 0.4, 0.4, 0.4);
        setVec3(lightingShaderProgram, "dirLight.specular", 0.5, 0.5, 0.5);
        // point light 1
        setVec3(lightingShaderProgram, "pointLights[0].position", pointLightPositions[0].x, pointLightPositions[0].y, pointLightPositions[0].z);
        setVec3(lightingShaderProgram, "pointLights[0].color", pointLightColors[0].x, pointLightColors[0].y, pointLightColors[0].z);
        setVec3(lightingShaderProgram, "pointLights[0].ambient", 0.05, 0.05, 0.05);
        setVec3(lightingShaderProgram, "pointLights[0].diffuse", 0.8, 0.8, 0.8);
        setVec3(lightingShaderProgram, "pointLights[0].specular", 1.0, 1.0, 1.0);
        setFloat(lightingShaderProgram, "pointLights[0].constant", 1.0);
        setFloat(lightingShaderProgram, "pointLights[0].linear", 0.09);
        setFloat(lightingShaderProgram, "pointLights[0].quadratic", 0.032);
        // point light 2
        setVec3(lightingShaderProgram, "pointLights[1].position", pointLightPositions[1].x, pointLightPositions[1].y, pointLightPositions[1].z);
        setVec3(lightingShaderProgram, "pointLights[1].color", pointLightColors[1].x, pointLightColors[1].y, pointLightColors[1].z);
        setVec3(lightingShaderProgram, "pointLights[1].ambient", 0.05, 0.05, 0.05);
        setVec3(lightingShaderProgram, "pointLights[1].diffuse", 0.8, 0.8, 0.8);
        setVec3(lightingShaderProgram, "pointLights[1].specular", 1.0, 1.0, 1.0);
        setFloat(lightingShaderProgram, "pointLights[1].constant", 1.0);
        setFloat(lightingShaderProgram, "pointLights[1].linear", 0.09);
        setFloat(lightingShaderProgram, "pointLights[1].quadratic", 0.032);
        // point light 3
        setVec3(lightingShaderProgram, "pointLights[2].position", pointLightPositions[2].x, pointLightPositions[2].y, pointLightPositions[2].z);
        setVec3(lightingShaderProgram, "pointLights[2].color", pointLightColors[2].x, pointLightColors[2].y, pointLightColors[2].z);
        setVec3(lightingShaderProgram, "pointLights[2].ambient", 0.05, 0.05, 0.05);
        setVec3(lightingShaderProgram, "pointLights[2].diffuse", 0.8, 0.8, 0.8);
        setVec3(lightingShaderProgram, "pointLights[2].specular", 1.0, 1.0, 1.0);
        setFloat(lightingShaderProgram, "pointLights[2].constant", 1.0);
        setFloat(lightingShaderProgram, "pointLights[2].linear", 0.09);
        setFloat(lightingShaderProgram, "pointLights[2].quadratic", 0.032);
        // point light 4
        setVec3(lightingShaderProgram, "pointLights[3].position", pointLightPositions[3].x, pointLightPositions[3].y, pointLightPositions[3].z);
        setVec3(lightingShaderProgram, "pointLights[3].color", pointLightColors[3].x, pointLightColors[3].y, pointLightColors[3].z);
        setVec3(lightingShaderProgram, "pointLights[3].ambient", 0.05, 0.05, 0.05);
        setVec3(lightingShaderProgram, "pointLights[3].diffuse", 0.8, 0.8, 0.8);
        setVec3(lightingShaderProgram, "pointLights[3].specular", 1.0, 1.0, 1.0);
        setFloat(lightingShaderProgram, "pointLights[3].constant", 1.0);
        setFloat(lightingShaderProgram, "pointLights[3].linear", 0.09);
        setFloat(lightingShaderProgram, "pointLights[3].quadratic", 0.032);
        // spotLight
        setVec3(lightingShaderProgram, "spotLight.position", camera_pos.x, camera_pos.y, camera_pos.z);
        setVec3(lightingShaderProgram, "spotLight.direction", camera_front.x, camera_front.y, camera_front.z);
        setVec3(lightingShaderProgram, "spotLight.ambient", 0.0, 0.0, 0.0);
        setVec3(lightingShaderProgram, "spotLight.diffuse", 1.0, 1.0, 1.0);
        setVec3(lightingShaderProgram, "spotLight.specular", 1.0, 1.0, 1.0);
        setFloat(lightingShaderProgram, "spotLight.constant", 1.0);
        setFloat(lightingShaderProgram, "spotLight.linear", 0.09);
        setFloat(lightingShaderProgram, "spotLight.quadratic", 0.032);
        setFloat(lightingShaderProgram, "spotLight.cutOff", cos(deg_to_rad(12.5)));
        setFloat(lightingShaderProgram, "spotLight.outerCutOff", cos(deg_to_rad(15.0)));

        glActiveTexture(GL_TEXTURE0);
        glBindTexture(GL_TEXTURE_2D, container_texture);
        glActiveTexture(GL_TEXTURE1);
        glBindTexture(GL_TEXTURE_2D, container_specular_texture);

        m_light_trans := make_translation_matrix4(xyz(0.0, 0.0, 0.0));
        glUniformMatrix4fv(model_loc2, 1, GL_TRUE, m_light_trans.floats.data);
        glBindVertexArray(cube_vao);
        //glDrawArrays(GL_TRIANGLES, 0, 36);

        for 0..9 {
            q : Quaternion;
            set_from_axis_and_angle(*q, 1.0, 0.3, 0.5,
                                    deg_to_rad(xx (get_time() * (it + 1) * 20)));
            m_rotate := rotation_matrix(Matrix4, q);
            m_trans := make_translation_matrix4(cube_positions[it]);

            model_matrix := m_trans * m_rotate; // m_trans * m_rotate * m_scale;
            glUniformMatrix4fv(model_loc2, 1, GL_TRUE, model_matrix.floats.data);
            glDrawArrays(GL_TRIANGLES, 0, 36);
        }

        /*
        m_trans2 := make_translation_matrix4(xyz(-0.5, 0.5, 0.0));
        scale_factor : float = xx sin(get_time());
        m_scale2 := make_scale_matrix4(xyz(scale_factor, scale_factor, scale_factor));
        finalMatrix2 := m_trans2 * m_scale2;
        glUniformMatrix4fv(model_loc, 1, GL_TRUE, finalMatrix2.floats.data);

        glUniform1f(visibilityLocation, 0.0);
        glBindVertexArray(vao);
        glDrawElements(GL_TRIANGLES, 6, GL_UNSIGNED_INT, null);
        */

        Simp.swap_buffers(window);
    }

    create_texture :: (tex_image: string) -> GLuint {
        new_texture : GLuint;
        glGenTextures(1, *new_texture);
        glBindTexture(GL_TEXTURE_2D, new_texture);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

        width, height, nrChannels : s32;
        //stbi_set_flip_vertically_on_load(true);
        data := stbi_load(to_c_string(tprint("../run_tree/textures/%", tex_image)), *width, *height, *nrChannels, 0);
        format : GLenum;
        if nrChannels == 1 {
            format = GL_RED;
        } else if nrChannels == 3 {
            format = GL_RGB;
        } else if nrChannels == 4 {
            format = GL_RGBA;
        }
        if data {
            glTexImage2D(GL_TEXTURE_2D, 0, xx format, xx width, xx height, 0, format, GL_UNSIGNED_BYTE, data);
            glGenerateMipmap(GL_TEXTURE_2D);
        } else {
            print("ERROR: Failed to load texture\n");
        }
        stbi_image_free(data);

        return new_texture;
    }

    setVec3 :: (shaderProgram: GLuint, uniform: *GLchar, x: float32, y: float32, z: float32) -> () {
        uniform_loc := glGetUniformLocation(shaderProgram, uniform);
        glUniform3f(uniform_loc, x, y, z);
    }
    setFloat :: (shaderProgram: GLuint, uniform: *GLchar, f: float32) -> () {
        uniform_loc := glGetUniformLocation(shaderProgram, uniform);
        glUniform1f(uniform_loc, f);
    }
}

deg_to_rad :: (deg: float) -> float {
    return deg * (PI / 180);
}

VERTEX_SHADER :: #string DONE
#version 330 core
layout (location = 0) in vec3 aPos;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
    gl_Position = projection * view * model * vec4(aPos, 1.0);
    //TexCoord = aTexCoord;
}
DONE

LIGHTING_VERTEX_SHADER :: #string DONE
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aNormal;
layout (location = 2) in vec2 aTexCoords;

out vec3 FragPos;
out vec3 Normal;
out vec2 TexCoords;

uniform mat4 model;
uniform mat4 view;
uniform mat4 projection;

void main()
{
    TexCoords = aTexCoords;
    FragPos = vec3(model * vec4(aPos, 1.0));
    Normal = mat3(transpose(inverse(model))) * aNormal;
    gl_Position = projection * view * model * vec4(aPos, 1.0);
}
DONE

FRAGMENT_SHADER :: #string DONE
#version 330 core
out vec4 FragColor;

uniform vec3 lightColor;

void main(){
    //FragColor = texture(ourTexture, -TexCoord);
    //FragColor = vec4(1.0);
    FragColor = vec4(lightColor, 1.0);
    //FragColor = mix(texture(ourTexture, vec2(TexCoord.x, 1 - TexCoord.y)), texture(textureDeux, TexCoord), visibility);
}
DONE

LIGHTING_FRAGMENT_SHADER :: #string DONE
#version 330 core
out vec4 FragColor;

#define NR_POINT_LIGHTS 4

in vec3 FragPos;
in vec3 Normal;
in vec2 TexCoords;

struct Material {
    sampler2D diffuse;
    sampler2D specular;
    float shininess;
};

struct DirLight {
    vec3 direction;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
};

struct PointLight {
    vec3 position;

    float constant;
    float linear;
    float quadratic;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;

    vec3 color;
};

struct SpotLight {
    vec3 position;
    vec3 direction;
    float cutOff;
    float outerCutOff;

    vec3 ambient;
    vec3 diffuse;
    vec3 specular;

    float constant;
    float linear;
    float quadratic;
};

uniform vec3 lightColor;
uniform vec3 viewPos;
uniform Material material;
uniform DirLight dirLight;
uniform PointLight pointLights[NR_POINT_LIGHTS];
uniform SpotLight spotLight;

vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir);
vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir);
vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir);

void main()
{
    // properties
    vec3 norm = normalize(Normal);
    vec3 viewDir = normalize(viewPos - FragPos);

    // phase 1: Directional lighting
    vec3 result = CalcDirLight(dirLight, norm, viewDir);
    // phase 2: Point lights
    for(int i = 0; i < NR_POINT_LIGHTS; i++)
        result += CalcPointLight(pointLights[i], norm, FragPos, viewDir);
    // phase 3: Spot light
    result += CalcSpotLight(spotLight, norm, FragPos, viewDir);

    FragColor = vec4(result, 1.0);
}

vec3 CalcDirLight(DirLight light, vec3 normal, vec3 viewDir) {
    vec3 lightDir = normalize(-light.direction);
    // diffuse shading
    float diff = max(dot(normal, lightDir), 0.0);
    // specular shading
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    // combine results
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoords));
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, TexCoords));
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoords));
    return (ambient + diffuse + specular);
}

vec3 CalcPointLight(PointLight light, vec3 normal, vec3 fragPos, vec3 viewDir) {
    vec3 lightDir = normalize(light.position - fragPos);
    // diffuse shading
    float diff = max(dot(normal, lightDir), 0.0);
    // specular shading
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    // attenuation
    float distance = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));

    vec3 ambient = attenuation * light.ambient * vec3(texture(material.diffuse, TexCoords));
    vec3 diffuse = attenuation * light.diffuse * diff * vec3(texture(material.diffuse, TexCoords));
    vec3 specular = attenuation * light.specular * spec * vec3(texture(material.specular, TexCoords));
    return light.color * (ambient + diffuse + specular);
}

vec3 CalcSpotLight(SpotLight light, vec3 normal, vec3 fragPos, vec3 viewDir) {
    // ambient
    vec3 ambient = light.ambient * vec3(texture(material.diffuse, TexCoords));

    // diffuse
    vec3 lightDir = normalize(light.position - fragPos);
    float diff = max(dot(normal, lightDir), 0.0);
    vec3 diffuse = light.diffuse * diff * vec3(texture(material.diffuse, TexCoords));

    // specular
    vec3 reflectDir = reflect(-lightDir, normal);
    float spec = pow(max(dot(viewDir, reflectDir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * vec3(texture(material.specular, TexCoords));

    // spotlight (soft edges)
    float theta = dot(lightDir, normalize(-light.direction));
    float epsilon = (light.cutOff - light.outerCutOff);
    float intensity = clamp((theta - light.outerCutOff) / epsilon, 0.0, 1.0);
    diffuse *= intensity;
    specular *= intensity;

    // attenuation
    float distance = length(light.position - fragPos);
    float attenuation = 1.0 / (light.constant + light.linear * distance + light.quadratic * (distance * distance));
    ambient *= attenuation;
    diffuse *= attenuation;
    specular *= attenuation;

    return (ambient + diffuse + specular);
}

DONE
