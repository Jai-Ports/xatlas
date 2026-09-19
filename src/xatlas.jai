// Generated directly from C++ by cpp_transpiler.
#load "cpp_transpiler_runtime.jai";

Array :: struct($T: Type) {
    base: Array_Base;
}

Array_Base :: struct {
    buffer: *u8;
    element_size: u32;
    size: u32;
    capacity: u32;
}

Invalid_Mesh_Geometry :: struct {
    faces: Array(u32);
    indices: Array(u32);
    vertex_to_source_vertex_map: Array(u32);
}

Param_Atlas :: struct {
    meshes: Array(*Internal_Mesh);
    invalid_mesh_geometry: Array(Invalid_Mesh_Geometry);
    mesh_chart_groups: Array(Array(*Chart_Group));
    charts_computed: bool;
}

Context :: struct {
    atlas: Atlas;
    add_mesh_progress: *Progress;
    add_mesh_task_group: Task_Group_Handle;
    param_atlas: Param_Atlas;
    progress_func: Progress_Func;
    progress_user_data: *void;
    task_scheduler: *Task_Scheduler;
    meshes: Array(*Internal_Mesh);
    mesh_polygon_mappings: Array(*Mesh_Polygon_Mapping);
    uv_meshes: Array(*Uv_Mesh);
    uv_mesh_instances: Array(*Uv_Mesh_Instance);
    uv_mesh_charts_computed: bool;
}

Task_Scheduler :: struct {
    groups: Array(*Task_Scheduler_Task_Group);
}

Task_Group_Handle :: struct {
    value: u32;
}

Progress :: struct {
    cancel: struct_atomic_Bool #align 8;
    layout_padding_0: [3] u8 #align 1;
    category: Progress_Category #align 1;
    func: Progress_Func #align 1;
    user_data: *void #align 1;
    value: struct_atomic_unsigned_int #align 1;
    max_value: struct_atomic_unsigned_int #align 1;
    percent: struct_atomic_unsigned_int #align 1;
    layout_padding_1: [4] u8 #align 1;
} #no_padding;

Bit_Array :: struct {
    size: u32;
    word_array: Array(u32);
}

Pack_Atlas :: struct {
    atlas_images: Array(*Atlas_Image);
    utilization: Array(float32);
    bit_images: Array(*Bit_Image);
    charts: Array(*Pack_Chart);
    radix: Radix_Sort;
    width: u32;
    height: u32;
    texels_per_unit: float32;
    rand: KISS_Rng;
}

KISS_Rng :: struct {
    x: u32;
    y: u32;
    z: u32;
    c: u32;
}

Radix_Sort :: struct {
    ranks: *u32;
    ranks2: *u32;
    buffer1: Array(u32);
    buffer2: Array(u32);
    valid_ranks: bool;
}

Uv_Mesh_Instance :: struct {
    mesh: *Uv_Mesh;
    texcoords: Array(Vector2);
}

Uv_Mesh :: struct {
    decl: Uv_Mesh_Decl;
    face_ignore: Bit_Array;
    face_materials: Array(u32);
    indices: Array(u32);
    texcoords: Array(Vector2);
    charts: Array(*Uv_Mesh_Chart);
    vertex_to_chart_map: Array(u32);
}

Task :: struct {
    func: #type (_: *void, _: *void);
    user_data: *void;
}

Triangulator :: struct {
    polygon_vertices: Array(s32);
    polygon_angles: Array(float32);
    polygon_points: Array(Vector2);
}

Mem_Tag_Values_in_xatlas :: u32;
INTERNAL_MEM_TAG_DEFAULT : Mem_Tag_Values_in_xatlas : 0;
INTERNAL_MEM_TAG_BIT_IMAGE : Mem_Tag_Values_in_xatlas : 1;
INTERNAL_MEM_TAG_BVH : Mem_Tag_Values_in_xatlas : 2;
INTERNAL_MEM_TAG_MATRIX : Mem_Tag_Values_in_xatlas : 3;
INTERNAL_MEM_TAG_MESH : Mem_Tag_Values_in_xatlas : 4;
INTERNAL_MEM_TAG_MESH_BOUNDARIES : Mem_Tag_Values_in_xatlas : 5;
INTERNAL_MEM_TAG_MESH_COLOCALS : Mem_Tag_Values_in_xatlas : 6;
INTERNAL_MEM_TAG_MESH_EDGE_MAP : Mem_Tag_Values_in_xatlas : 7;
INTERNAL_MEM_TAG_MESH_INDICES : Mem_Tag_Values_in_xatlas : 8;
INTERNAL_MEM_TAG_MESH_NORMALS : Mem_Tag_Values_in_xatlas : 9;
INTERNAL_MEM_TAG_MESH_POSITIONS : Mem_Tag_Values_in_xatlas : 10;
INTERNAL_MEM_TAG_MESH_TEXCOORDS : Mem_Tag_Values_in_xatlas : 11;
INTERNAL_MEM_TAG_OPEN_NL : Mem_Tag_Values_in_xatlas : 12;
INTERNAL_MEM_TAG_SEGMENT_ATLAS_CHART_CANDIDATES : Mem_Tag_Values_in_xatlas : 13;
INTERNAL_MEM_TAG_SEGMENT_ATLAS_CHART_FACES : Mem_Tag_Values_in_xatlas : 14;
INTERNAL_MEM_TAG_SEGMENT_ATLAS_MESH_DATA : Mem_Tag_Values_in_xatlas : 15;
INTERNAL_MEM_TAG_SEGMENT_ATLAS_PLANAR_REGIONS : Mem_Tag_Values_in_xatlas : 16;
INTERNAL_MEM_TAG_COUNT : Mem_Tag_Values_in_xatlas : 17;

Vector2 :: struct {
    x: float32;
    y: float32;
}

Vector3 :: struct {
    x: float32;
    y: float32;
    z: float32;
}

Internal_Mesh :: struct {
    epsilon: float32;
    flags: u32;
    id: u32;
    face_ignore: Array(bool);
    face_materials: Array(u32);
    indices: Array(u32);
    positions: Array(Vector3);
    normals: Array(Vector3);
    texcoords: Array(Vector2);
    next_colocal_vertex: Array(u32);
    first_colocal_vertex: Array(u32);
    is_boundary_vertex: Bit_Array;
    boundary_edges: Array(u32);
    opposite_edges: Array(u32);
    edge_map: Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key));
}

Hash_Map :: struct($Key: Type, $H: Type, $E: Type) {
    mem_tag: s32;
    size: u32;
    num_slots: u32;
    slots: *u32;
    keys: Array(Key);
    next: Array(u32);
}

Pack_Chart :: struct {
    atlas_index: s32;
    material: u32;
    indices: Const_Array_View(u32);
    parametric_area: float32;
    surface_area: float32;
    vertices: Array_View(Vector2);
    unique_vertices: Array(u32);
    major_axis: Vector2;
    minor_axis: Vector2;
    min_corner: Vector2;
    max_corner: Vector2;
    boundary_edges: *Array(u32);
    faces: Array(u32);
}

Bit_Image :: struct {
    width: u32;
    height: u32;
    row_stride: u32;
    data: Array(u64);
}

Atlas_Draw_Triangle_Callback_Args :: struct {
    chart_bit_image: *Bit_Image;
    chart_bit_image_rotated: *Bit_Image;
}

Uniform_Grid2 :: struct {
    edges: Array(u32);
    positions: Const_Array_View(Vector2);
    indices: Const_Array_View(u32);
    cell_size: float32;
    grid_origin: Vector2;
    grid_width: u32;
    grid_height: u32;
    cell_data_offsets: Array(u32);
    cell_data: Array(u32);
    potential_edges: Array(u32);
    traversed_cell_offsets: Array(u32);
}

Bounding_Box2_D :: struct {
    major_axis: Vector2;
    minor_axis: Vector2;
    min_corner: Vector2;
    max_corner: Vector2;
    boundary_vertices: Array(Vector2);
    coords: Array(float32);
    top: Array(Vector2);
    bottom: Array(Vector2);
    hull: Array(Vector2);
    radix: Radix_Sort;
}

Task_Scheduler_Task_Group :: struct {
    queue: Array(Task);
    user_data: *void;
}

Param_Chart :: struct {
    basis: Basis;
    unified_mesh: *Internal_Mesh;
    type: Chart_Type;
    generator_type: Chart_Generator_Type_Enum;
    tjunction_count: u32;
    original_vertex_count: u32;
    original_indices: Array(u32);
    face_to_source_face_map: Array(u32);
    vertex_to_source_vertex_map: Array(u32);
    chart_vertex_to_unified_vertex_map: Array(u32);
    backup_texcoords: Array(Vector2);
    quality: Quality;
    is_invalid: bool;
}

Quality :: struct {
    boundary_intersection: bool;
    total_triangle_count: u32;
    flipped_triangle_count: u32;
    zero_area_triangle_count: u32;
    total_parametric_area: float32;
    total_geometric_area: float32;
    stretch_metric: float32;
    max_stretch_metric: float32;
    conformal_metric: float32;
    authalic_metric: float32;
}

Chart_Generator_Type_Enum :: u32;
INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_ORIGINAL_UV : Chart_Generator_Type_Enum : 0;
INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_PLANAR : Chart_Generator_Type_Enum : 1;
INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_CLUSTERED : Chart_Generator_Type_Enum : 2;
INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_PIECEWISE : Chart_Generator_Type_Enum : 3;

Basis :: struct {
    tangent: Vector3;
    bitangent: Vector3;
    normal: Vector3;
}

Add_Chart_Task_Args :: struct {
    param_chart: *Param_Chart;
    chart: *Pack_Chart;
}

Mesh_Compute_Charts_Task_Group_Args :: struct {
    atlas: *Thread_Local(Segment_Atlas);
    options: *Chart_Options;
    progress: *Progress;
    task_scheduler: *Task_Scheduler;
    boundary_grid: *Thread_Local(Uniform_Grid2);
    chart_buffers: *Thread_Local(Chart_Ctor_Buffers);
    piecewise_param: *Thread_Local(Piecewise_Param);
}

Piecewise_Param :: struct {
    mesh: *Internal_Mesh;
    texcoords: Array(Vector2);
    face_in_any_patch: Bit_Array;
    candidates: Array(*Piecewise_Param_Candidate);
    face_to_candidate: Array(*Piecewise_Param_Candidate);
    patch: Array(u32);
    face_in_patch: Bit_Array;
    vertex_in_patch: Bit_Array;
    face_invalid: Bit_Array;
    boundary_grid: Uniform_Grid2;
    new_boundary_edges: Array(u32);
    ignore_boundary_edges: Array(u32);
}

Chart_Ctor_Buffers :: struct {
    chart_mesh_indices: Array(u32);
    unified_mesh_indices: Array(u32);
}

Thread_Local :: struct($T: Type) {
    array: *T;
}

Segment_Atlas :: struct {
    data: Atlas_Data;
    original_uv_charts: Original_Uv_Charts;
    planar_charts: Planar_Charts;
    clustered_charts: Clustered_Charts;
}

Clustered_Charts :: struct {
    data: *Atlas_Data;
    planar_charts: *Planar_Charts;
    texcoords: Array(Vector2);
    faces_left: u32;
    face_charts: Array(s32);
    charts: Array(*Clustered_Charts_Chart);
    best_triangles: Cost_Queue;
    temp_points: Array(Vector3);
    boundary_grid: Uniform_Grid2;
    shared_boundary_lengths: Array(float32);
    shared_boundary_lengths_no_seams: Array(float32);
    shared_boundary_edge_count_no_seams: Array(u32);
    placing_seeds: bool;
}

Cost_Queue :: struct {
    max_size: u32;
    pairs: Array(Cost_Queue_Pair);
}

Planar_Charts :: struct {
    data: *Atlas_Data;
    region_first_face: Array(u32);
    next_region_face: Array(u32);
    face_to_region_id: Array(u32);
    region_areas: Array(float32);
    charts: Array(Planar_Charts_Chart);
    chart_faces: Array(u32);
    chart_basis: Array(Basis);
}

Atlas_Data :: struct {
    options: Chart_Options;
    mesh: *Internal_Mesh;
    edge_dihedral_angles: Array(float32);
    edge_lengths: Array(float32);
    face_areas: Array(float32);
    face_uv_areas: Array(float32);
    face_normals: Array(Vector3);
    is_face_in_chart: Bit_Array;
}

Original_Uv_Charts :: struct {
    data: *Atlas_Data;
    charts: Array(Original_Uv_Charts_Chart);
    chart_basis: Array(Basis);
    chart_faces: Array(u32);
    temp_points: Array(Vector3);
}

Mesh_Face_Groups :: struct {
    mesh: *Internal_Mesh;
    groups: Array(u32);
    first_face: Array(u32);
    next_face: Array(u32);
    face_count: Array(u32);
}

Chart_Group_Compute_Charts_Task_Group_Args :: struct {
    atlas: *Thread_Local(Segment_Atlas);
    options: *Chart_Options;
    progress: *Progress;
    task_scheduler: *Task_Scheduler;
    boundary_grid: *Thread_Local(Uniform_Grid2);
    chart_buffers: *Thread_Local(Chart_Ctor_Buffers);
    piecewise_param: *Thread_Local(Piecewise_Param);
}

Chart_Group :: struct {
    id: u32;
    source_mesh: *Internal_Mesh;
    source_mesh_face_groups: *Mesh_Face_Groups;
    face_group: Mesh_Face_Groups_Handle;
    face_to_source_face_map: Array(u32);
    charts: Array(*Param_Chart);
}

Mesh_Face_Groups_Handle :: u32;

Mesh_Face_Groups_Iterator :: struct {
    mesh_face_groups: *Mesh_Face_Groups;
    current: u32;
}

Create_And_Parameterize_Chart_Task_Group_Args :: struct {
    progress: *Progress;
    boundary_grid: *Thread_Local(Uniform_Grid2);
    chart_buffers: *Thread_Local(Chart_Ctor_Buffers);
    options: *Chart_Options;
    pp: *Thread_Local(Piecewise_Param);
}

Clustered_Charts_Chart :: struct {
    id: s32;
    basis: Basis;
    area: float32;
    boundary_length: float32;
    centroid_sum: Vector3;
    centroid: Vector3;
    faces: Array(u32);
    failed_planar_regions: Array(u32);
    candidates: Cost_Queue;
    seed: u32;
}

Planar_Charts_Chart :: struct {
    first_face: u32;
    face_count: u32;
}

Original_Uv_Charts_Chart :: struct {
    first_face: u32;
    face_count: u32;
}

Piecewise_Param_Candidate_Iterator :: struct {
    current: *Piecewise_Param_Candidate;
}

Piecewise_Param_Candidate :: struct {
    face: u32;
    vertex: u32;
    prev: *Piecewise_Param_Candidate;
    next: *Piecewise_Param_Candidate;
    position: Vector2;
    cost: float32;
    max_cost: float32;
    patch_edge: u32;
    patch_vertex_orient: float32;
}

Mesh_Face_Edge_Iterator :: struct {
    mesh: *Internal_Mesh;
    face: u32;
    edge: u32;
    relative_edge: u32;
}

Const_Array_View :: struct($T: Type) {
    data: *T;
    length: u32;
}

Compute_Uv_Mesh_Charts_Task :: struct {
    mesh: *Uv_Mesh;
    progress: *Progress;
    uv_to_edge_map: Hash_Map(Vector2, Hash(Vector2), Equal(Vector2));
    face_assigned: Bit_Array;
}

Compute_Uv_Mesh_Charts_Task_Args :: struct {
    mesh: *Uv_Mesh;
    progress: *Progress;
}

Uv_Mesh_Chart :: struct {
    faces: Array(u32);
    indices: Array(u32);
    material: u32;
}

Cost_Queue_Pair :: struct {
    cost: float32;
    face: u32;
}

Triangle :: struct {
    v1: Vector2;
    v2: Vector2;
    v3: Vector2;
    n1: Vector2;
    n2: Vector2;
    n3: Vector2;
}

Clipped_Triangle :: struct {
    vertices_a: [8] Vector2;
    vertices_b: [8] Vector2;
    vertex_buffers: [2] *Vector2;
    num_vertices: u32;
    active_vertex_buffer: u32;
    area: float32;
}

Extents2 :: struct {
    min: Vector2;
    max: Vector2;
}

Edge_Key :: struct {
    v0: u32;
    v1: u32;
}

BVH :: struct {
    object_aabbs: *Array(AABB);
    object_ids: Array(u32);
    nodes: Array(BVH_Node);
}

Passthrough_Hash :: struct($Key: Type) {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

Hash :: struct($Key: Type) {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

Equal :: struct($Key: Type) {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

Edge_Hash :: struct {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

AABB :: struct {
    min: Vector3;
    max: Vector3;
}

BVH_Build_Entry :: struct {
    parent: u32;
    start: u32;
    end: u32;
}

BVH_Node :: struct {
    aabb: AABB;
    start: u32;
    n_prims: u32;
    right_offset: u32;
}

Float_Uint32 :: union {
    f: float32;
    u: u32;
}

Mesh_Polygon_Mapping :: struct {
    face_vertex_count: Array(u8);
    triangle_to_polygon_map: Array(u32);
    triangle_to_polygon_indices_map: Array(u32);
}

Atlas_Image :: struct {
    width: u32;
    height: u32;
    data: Array(u32);
}

Vector2i :: struct {
    x: s32;
    y: s32;
}

Sampling_Callback :: #type (_: *void, _: s32, _: s32) -> bool;

Create_And_Parameterize_Chart_Task_Args :: struct {
    basis: *Basis;
    chart: *Param_Chart;
    charts: Array(*Param_Chart);
    chart_generator_type: Chart_Generator_Type_Enum;
    mesh: *Internal_Mesh;
    faces: Const_Array_View(u32);
    chart_group_id: u32;
    chart_id: u32;
}

NL_Context :: struct {
    variable_buffer: *NL_Buffer_Binding;
    variable_value: *float64;
    variable_is_locked: *bool;
    variable_index: *u32;
    n: u32;
    m: NL_Matrix;
    p: NL_Matrix;
    b_2: NL_Matrix;
    af: NL_Row_Column;
    al: NL_Row_Column;
    x: *float64;
    b: *float64;
    nb_variables: u32;
    nb_systems: u32;
    current_row: u32;
    max_iterations: u32;
    max_iterations_defined: bool;
    threshold: float64;
    omega: float64;
    used_iterations: u32;
    error: float64;
}

NL_Row_Column :: struct {
    size: u32;
    capacity: u32;
    coeff: *NL_Coeff;
}

NL_Coeff :: struct {
    index: u32;
    value: float64;
}

NL_Matrix :: *NL_Matrix_Struct;

NL_Matrix_Struct :: struct {
    m: u32;
    n: u32;
    type: u32;
    destroy_func: NL_Destroy_Matrix_Func;
    mult_func: NL_Mult_Matrix_Vector_Func;
}

NL_Mult_Matrix_Vector_Func :: #type (_: NL_Matrix, _: *float64, _: *float64);

NL_Destroy_Matrix_Func :: #type (_: NL_Matrix);

NL_Buffer_Binding :: struct {
    base_address: *void;
    stride: u32;
}

NL_Sparse_Matrix :: struct {
    m: u32;
    n: u32;
    type: u32;
    destroy_func: NL_Destroy_Matrix_Func;
    mult_func: NL_Mult_Matrix_Vector_Func;
    diag_size: u32;
    diag_capacity: u32;
    row: *NL_Row_Column;
    column: *NL_Row_Column;
    diag: *float64;
    row_capacity: u32;
    column_capacity: u32;
}

NLCRS_Matrix :: struct {
    m: u32;
    n: u32;
    type: u32;
    destroy_func: NL_Destroy_Matrix_Func;
    mult_func: NL_Mult_Matrix_Vector_Func;
    val: *float64;
    rowptr: *u32;
    colind: *u32;
    nslices: u32;
    sliceptr: *u32;
}

NL_Jacobi_Preconditioner :: struct {
    m: u32;
    n: u32;
    type: u32;
    destroy_func: NL_Destroy_Matrix_Func;
    mult_func: NL_Mult_Matrix_Vector_Func;
    diag_inv: *float64;
}

Mesh_Flags_Values_in_xatlas :: u32;
INTERNAL_MESH_FLAGS_HAS_IGNORED_FACES : Mesh_Flags_Values_in_xatlas : 1;
INTERNAL_MESH_FLAGS_HAS_NORMALS : Mesh_Flags_Values_in_xatlas : 2;
INTERNAL_MESH_FLAGS_HAS_MATERIALS : Mesh_Flags_Values_in_xatlas : 4;

Mesh_Compute_Charts_Task_Args :: struct {
    source_mesh: *Internal_Mesh;
    chart_groups: *Array(*Chart_Group);
    invalid_mesh_geometry: *Invalid_Mesh_Geometry;
}

Spinlock :: struct {
    lock: atomic_flag #align 1;
} #no_padding;

Thread_Local_T :: struct {
} #no_padding;

Hash_Map_Key_H_E :: struct {
} #no_padding;

Const_Array_View_T :: struct {
} #no_padding;

Array_View_T :: struct {
} #no_padding;

Array_T :: struct {
} #no_padding;

Array_View :: struct($T: Type) {
    data: *T;
    length: u32;
}

Mem_Tag :: struct {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

Fit :: struct {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

Mesh_Flags :: struct {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

Chart_Generator_Type :: struct {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

s_realloc: Realloc_Func;

s_free: Free_Func;

K_NORMAL_EPSILON: float32;

s_print: Print_Func;

s_print_verbose: bool;

K_IMAGE_IS_PADDING_BIT: u32;

K_IMAGE_HAS_CHART_INDEX_BIT: u32;

K_IMAGE_IS_BILINEAR_BIT: u32;

K_EPSILON: float32;

K_AREA_EPSILON: float32;

K_PI: float32;

INTERNAL_MESH_FACE_GROUPS_K_INVALID: Mesh_Face_Groups_Handle;

K_PI2: float32;

K_IMAGE_CHART_INDEX_MASK: u32;

vertices :: (using invalid_mesh_geometry_2: *Invalid_Mesh_Geometry) -> Const_Array_View(u32) {
    return make_struct_xatlas_internal_const_array_view_unsigned_int(*vertex_to_source_vertex_map);
}

invalid_mesh_geometry :: (using atlas: *Param_Atlas, mesh_index: u32) -> *Invalid_Mesh_Geometry {
    return *(invalid_mesh_geometry[mesh_index]);
}

operator *[] :: (using array: *Array(Invalid_Mesh_Geometry), index: u32) -> *Invalid_Mesh_Geometry {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Invalid_Mesh_Geometry) base.buffer)[index];
}

indices :: (using invalid_mesh_geometry_2: *Invalid_Mesh_Geometry) -> Const_Array_View(u32) {
    return make_struct_xatlas_internal_const_array_view_unsigned_int(*indices);
}

faces :: (using invalid_mesh_geometry_2: *Invalid_Mesh_Geometry) -> Const_Array_View(u32) {
    return make_struct_xatlas_internal_const_array_view_unsigned_int(*faces);
}

unique_vertex_at :: (using chart: *Pack_Chart, v: u32) -> *Vector2 {
    return ifx is_empty(*unique_vertices) then (cast(**Vector2) *(index_explicit_2(*vertices, v))).* else (cast(**Vector2) *(index_explicit_2(*vertices, ((cast(**u32) *(index_explicit(*unique_vertices, v))).*).*))).*;
}

index_explicit :: (using array: *Array(u32), index: u32) -> *u32 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*u32) base.buffer)[index];
}

index_explicit_2 :: (using array_view: *Array_View(Vector2), index: u32) -> *Vector2 {
    assert(index < length);
    return *data[index];
}

is_empty :: (using array: *Array(u32)) -> bool {
    return base.size == 0;
}

size :: (using array: *Array(*Pack_Chart)) -> u32 {
    return base.size;
}

ranks :: (using radix_sort_2: *Radix_Sort) -> *u32 {
    assert(valid_ranks);
    return ranks;
}

index_explicit_3 :: (using array: *Array(*Pack_Chart), index: u32) -> **Pack_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Pack_Chart) base.buffer)[index];
}

internal_operator :: (a: *Vector2, b: *Vector2) -> Vector2 {
    return make_vector2(a.x - b.x, a.y - b.y);
}

internal_operator :: (v: *Vector2, s: float32) -> Vector2 {
    return make_vector2(v.x * s, v.y * s);
}

size :: (using array: *Array(Vector2)) -> u32 {
    return base.size;
}

create_task_group :: (using task_scheduler: *Task_Scheduler, user_data: *void, reserve_size: u32) -> Task_Group_Handle {
    group :=
        cast(*Task_Scheduler_Task_Group) (cast(*void) (cast(*Task_Scheduler_Task_Group) internal_realloc(
            null,
            32,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            3320
        )));
    init(group);
    reserve(*group.queue, reserve_size);
    group.user_data = user_data;
    push_back(*groups, *group);
    handle: Task_Group_Handle = ---;
    init(*handle);
    handle.value = size(*groups) - 1;
    return handle;
}

size :: (using array: *Array(*Task_Scheduler_Task_Group)) -> u32 {
    return base.size;
}

push_back :: (using array: *Array(*Task_Scheduler_Task_Group), value: **Task_Scheduler_Task_Group) {
    push_back(*base, cast(*u8) (cast(**Task_Scheduler_Task_Group) value));
}

push_back :: (using array_base: *Array_Base, value: *u8) {
    assert(value < buffer || value >= buffer + size);
    assert(value != null);
    resize(array_base, size + 1, false);
    assert(buffer != null);
    if buffer != null && value != null {
        copy_memory(*buffer[(size - 1) * element_size], value, cast,no_check(u64) element_size);
    }
}

resize :: (using array_base: *Array_Base, new_size: u32, exact: bool) {
    size = new_size;
    if size > capacity {
        new_buffer_size: u32 = ifx capacity == 0 || exact
            then size
            else size + size >> 2;
        set_array_capacity(array_base, new_buffer_size);
    }
}

set_array_capacity :: (using array_base: *Array_Base, new_capacity: u32) {
    assert(new_capacity >= size);
    if new_capacity == 0 {
        if buffer != null {
            internal_realloc(
                cast(*void) buffer,
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                1104
            );
            buffer = cast(*u8) null;
        }
    } else {
        buffer =
            cast(*u8) internal_realloc(
                cast(*void) buffer,
                cast,no_check(u64) (new_capacity * element_size),
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                1112
            );
    }
    capacity = new_capacity;
}

internal_realloc :: (ptr: *void, size_3: u64, unnamed_1523: s32, unnamed_1524: *s8, unnamed_1525: s32) -> *void {
    if size_3 == 0 && ptr == null {
        return null;
    }
    if size_3 == 0 && s_free != null {
        s_free(ptr);
        return null;
    }

    mem := s_realloc(ptr, size_3);

    assert(size_3 <= 0 || size_3 > 0 && mem != null);
    return mem;
}

reserve :: (using array: *Array(Task), desired_size: u32) {
    reserve(*base, desired_size);
}

reserve :: (using array_base: *Array_Base, desired_size: u32) {
    if desired_size > capacity {
        set_array_capacity(array_base, desired_size);
    }
}

compute_parametric_bounds :: (using chart: *Param_Chart) -> Vector2 {
    min_corner: Vector2 = make_vector2(cast(float32) 3.40282347e+38, cast(float32) 3.40282347e+38);
    max_corner: Vector2 = make_vector2(-cast(float32) 3.40282347e+38, -cast(float32) 3.40282347e+38);
    VERTEX_COUNT := vertex_count(unified_mesh);
    if 0 < VERTEX_COUNT {
        for v: 0..VERTEX_COUNT - 1 {
            assign(
                *min_corner,
                (ifx true { temporary___g0: Vector2 = internal_min(*min_corner, texcoord(unified_mesh, v)); *temporary___g0; })
            );
            assign(
                *max_corner,
                (ifx true { temporary___g1: Vector2 = internal_max(*max_corner, texcoord(unified_mesh, v)); *temporary___g1; })
            );
        }
    }
    return internal_operator(
        (ifx true { temporary___g2: Vector2 = internal_operator(*max_corner, *min_corner); *temporary___g2; }),
        0.5
    );
}

texcoord :: (using mesh: *Internal_Mesh, vertex: u32) -> *Vector2 {
    return index_explicit_4(*texcoords, vertex);
}

index_explicit_4 :: (using array: *Array(Vector2), index: u32) -> *Vector2 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Vector2) base.buffer)[index];
}

internal_max :: (a: *Vector2, b: *Vector2) -> Vector2 {
    return make_vector2(internal_max(*a.x, *b.x), internal_max(*a.y, *b.y));
}

internal_max :: (a: *float32, b: *float32) -> float32 {
    return ifx a.* > b.* then a.* else b.*;
}

assign :: inline (using vector2: *Vector2, unnamed_2162: *Vector2) -> *Vector2 {
    vector2.* = ((cast(**Vector2) *(unnamed_2162)).*).*;
    return (cast(**Vector2) *(vector2)).*;
}

internal_min :: (a: *Vector2, b: *Vector2) -> Vector2 {
    return make_vector2(internal_min(*a.x, *b.x), internal_min(*a.y, *b.y));
}

internal_min :: (a: *float32, b: *float32) -> float32 {
    return ifx a.* < b.* then a.* else b.*;
}

vertex_count :: (using mesh: *Internal_Mesh) -> u32 {
    return size(*positions);
}

size :: (using array: *Array(Vector3)) -> u32 {
    return base.size;
}

size :: (using array: *Array(*Internal_Mesh)) -> u32 {
    return base.size;
}

group_count :: (using mesh_face_groups: *Mesh_Face_Groups) -> u32 {
    return size(*face_count);
}

size :: (using array: *Array(u32)) -> u32 {
    return base.size;
}

internal_min :: (a: *u32, b: *u32) -> u32 {
    return min(a.*, b.*);
}

chart_count :: (using atlas: *Segment_Atlas) -> u32 {
    return chart_count(*original_uv_charts) + chart_count(*planar_charts) + chart_count(*clustered_charts);
}

chart_count :: (using clustered_charts: *Clustered_Charts) -> u32 {
    return size(*charts);
}

size :: (using array: *Array(*Clustered_Charts_Chart)) -> u32 {
    return base.size;
}

chart_count :: (using planar_charts: *Planar_Charts) -> u32 {
    return size(*charts);
}

size :: (using array: *Array(Planar_Charts_Chart)) -> u32 {
    return base.size;
}

chart_count :: (using original_uv_charts: *Original_Uv_Charts) -> u32 {
    return size(*charts);
}

size :: (using array: *Array(Original_Uv_Charts_Chart)) -> u32 {
    return base.size;
}

chart_faces :: (using atlas: *Segment_Atlas, chart_index: u32) -> Const_Array_View(u32) {
    if chart_index < chart_count(*original_uv_charts) {
        return chart_faces(*original_uv_charts, chart_index);
    }
    chart_index -= chart_count(*original_uv_charts);
    if chart_index < chart_count(*planar_charts) {
        return chart_faces(*planar_charts, chart_index);
    }
    chart_index -= chart_count(*planar_charts);
    return chart_faces(*clustered_charts, chart_index);
}

chart_faces :: (using clustered_charts: *Clustered_Charts, chart_index: u32) -> Const_Array_View(u32) {
    return make_struct_xatlas_internal_const_array_view_unsigned_int(
        *(((cast(**Clustered_Charts_Chart) index_explicit_5(*charts, chart_index)).*).faces)
    );
}

index_explicit_5 :: (using array: *Array(*Clustered_Charts_Chart), index: u32) -> **Clustered_Charts_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Clustered_Charts_Chart) base.buffer)[index];
}

chart_faces :: (using planar_charts: *Planar_Charts, chart_index: u32) -> Const_Array_View(u32) {
    chart: *Planar_Charts_Chart = cast,no_check(*Planar_Charts_Chart) index_explicit_6(*charts, chart_index);
    return make_struct_xatlas_internal_const_array_view_unsigned_int(
        (cast(**u32) *(index_explicit_7(*chart_faces, chart.first_face))).*,
        chart.face_count
    );
}

index_explicit_6 :: (using array: *Array(Planar_Charts_Chart), index: u32) -> *Planar_Charts_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Planar_Charts_Chart) base.buffer)[index];
}

index_explicit_7 :: (using array: *Array(u32), index: u32) -> *u32 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*u32) base.buffer)[index];
}

chart_faces :: (using original_uv_charts: *Original_Uv_Charts, chart_index: u32) -> Const_Array_View(u32) {
    chart: *Original_Uv_Charts_Chart =
        cast,no_check(*Original_Uv_Charts_Chart) index_explicit_8(
            *charts,
            chart_index
        );
    return make_struct_xatlas_internal_const_array_view_unsigned_int(
        (cast(**u32) *(index_explicit_7(*chart_faces, chart.first_face))).*,
        chart.face_count
    );
}

index_explicit_8 :: (using array: *Array(Original_Uv_Charts_Chart), index: u32) -> *Original_Uv_Charts_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Original_Uv_Charts_Chart) base.buffer)[index];
}

internal_operator :: (v: *Vector3, s: float32) -> Vector3 {
    return make_vector3(v.x * s, v.y * s, v.z * s);
}

internal_operator :: (a: *Vector3, b: *Vector3) -> Vector3 {
    return make_vector3(a.x + b.x, a.y + b.y, a.z + b.z);
}

internal_operator_in_xatlas :: (v: *Vector3, s: float32) -> Vector3 {
    return internal_operator(v, 1.0 / s);
}

vertex_at :: (using mesh: *Internal_Mesh, i: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*indices, i))).*).*;
}

position :: (using mesh: *Internal_Mesh, vertex: u32) -> *Vector3 {
    return index_explicit_9(*positions, vertex);
}

index_explicit_9 :: (using array: *Array(Vector3), index: u32) -> *Vector3 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Vector3) base.buffer)[index];
}

internal_operator_in_xatlas_2 :: (a: *Vector3, b: *Vector3) -> Vector3 {
    return make_vector3(a.x - b.x, a.y - b.y, a.z - b.z);
}

internal_normalize :: (v: *Vector3) -> Vector3 {
    L := internal_length(v);
    assert(L > 0.0);
    N := internal_operator(v, 1.0 / L);
    assert(internal_is_normalized(*N, K_NORMAL_EPSILON));
    return N;
}

internal_length :: (v: *Vector3) -> float32 {
    return sqrtf(internal_length_squared(v));
}

internal_length_squared :: (v: *Vector3) -> float32 {
    return v.x * v.x + v.y * v.y + v.z * v.z;
}

internal_is_normalized :: (v: *Vector3, epsilon_2: float32) -> bool {
    return internal_equal(internal_length(v), 1.0, epsilon_2);
}

internal_equal :: (F0: float32, F1: float32, EPSILON: float32) -> bool {
    return std_fabs(F0 - F1) <= EPSILON * internal_max3(
        (ifx true { temporary___g0: float32 = 1.0; *temporary___g0; }),
        (ifx true { temporary___g1: float32 = fabsf(F0); *temporary___g1; }),
        (ifx true { temporary___g2: float32 = fabsf(F1); *temporary___g2; })
    );
}

internal_max3 :: (a: *float32, b: *float32, c_: *float32) -> float32 {
    return internal_max(a, (ifx true { temporary___g0: float32 = internal_max(b, c_); *temporary___g0; }));
}

std_fabs :: (x: float32) -> float32 {
    return c_transpiler_fabs(x);
}

compute_face_normal :: (using mesh: *Internal_Mesh, face_2: u32) -> Vector3 {
    p0: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 0))).*).*
        );
    p1: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 1))).*).*
        );
    p2: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 2))).*).*
        );
    E0 := internal_operator_in_xatlas_2(p2, p0);
    E1 := internal_operator_in_xatlas_2(p1, p0);
    NORMAL_AREA_SCALED := internal_cross(*E0, *E1);
    return internal_normalize_safe(
        *NORMAL_AREA_SCALED,
        (ifx true { temporary___g0: Vector3 = make_vector3(0, 0, 1); *temporary___g0; })
    );
}

internal_cross :: (a: *Vector3, b: *Vector3) -> Vector3 {
    return make_vector3(a.y * b.z - a.z * b.y, a.z * b.x - a.x * b.z, a.x * b.y - a.y * b.x);
}

internal_normalize_safe :: (v: *Vector3, fallback: *Vector3) -> Vector3 {
    L := internal_length(v);
    if L > 0.0 {
        return internal_operator(v, 1.0 / L);
    }
    return fallback.*;
}

subtract :: (using vector3: *Vector3) -> Vector3 {
    return make_vector3(-x, -y, -z);
}

linked_candidate_head :: (
    using piecewise_param: *Piecewise_Param,
    candidate: *Piecewise_Param_Candidate
) -> *Piecewise_Param_Candidate {
    current_2 := candidate;
    while true {
        if current_2.prev == null {
            break;
        }
        current_2 = cast,no_check(*Piecewise_Param_Candidate) current_2.prev;
    }
    return current_2;
}

internal_mesh_edge_index0 :: (edge_2: u32) -> u32 {
    return edge_2;
}

internal_mesh_edge_index1 :: (edge_2: u32) -> u32 {
    FACE_FIRST_EDGE := (edge_2 / 3) * 3;
    return FACE_FIRST_EDGE + (edge_2 - FACE_FIRST_EDGE + 1) % 3;
}

current :: (using candidate_iterator: *Piecewise_Param_Candidate_Iterator) -> *Piecewise_Param_Candidate {
    return current;
}

indices :: (using mesh: *Internal_Mesh) -> Const_Array_View(u32) {
    return make_struct_xatlas_internal_const_array_view_unsigned_int(*indices);
}

positions :: (using mesh: *Internal_Mesh) -> Const_Array_View(Vector3) {
    return make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector3(*positions);
}

texcoords :: (using mesh: *Internal_Mesh) -> Array_View(Vector2) {
    return make_struct_xatlas_internal_array_view_class_xatlas_internal_vector2(*texcoords);
}

index_explicit_10 :: (using array: *Array(Vector3), index: u32) -> *Vector3 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Vector3) base.buffer)[index];
}

pop :: (using cost_queue: *Cost_Queue) -> u32 {
    assert(!is_empty(*pairs));
    f := (back(*pairs)).face;
    pop_back(*pairs);
    return f;
}

back :: (using array: *Array(Cost_Queue_Pair)) -> *Cost_Queue_Pair {
    assert(!is_empty(array));
    return *(cast(*Cost_Queue_Pair) base.buffer)[base.size - 1];
}

is_empty :: (using array: *Array(Cost_Queue_Pair)) -> bool {
    return base.size == 0;
}

pop_back :: (using array: *Array(Cost_Queue_Pair)) {
    pop_back(*base);
}

pop_back :: (using array_base: *Array_Base) {
    assert(size > 0);
    resize(array_base, size - 1, false);
}

compute_face_center :: (using mesh: *Internal_Mesh, face_2: u32) -> Vector3 {
    p0: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 0))).*).*
        );
    p1: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 1))).*).*
        );
    p2: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 2))).*).*
        );
    L0 :=
        internal_length(
            (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(p1, p0); *temporary___g0; })
        );
    L1 :=
        internal_length(
            (ifx true { temporary___g1: Vector3 = internal_operator_in_xatlas_2(p2, p1); *temporary___g1; })
        );
    L2 :=
        internal_length(
            (ifx true { temporary___g2: Vector3 = internal_operator_in_xatlas_2(p0, p2); *temporary___g2; })
        );
    M0 :=
        internal_operator_in_xatlas(
            (ifx true { temporary___g3: Vector3 = internal_operator(
            (ifx true { temporary___g4: Vector3 = internal_operator(p0, p1); *temporary___g4; }),
            L0
        ); *temporary___g3; }),
            L0 + L1 + L2
        );
    M1 :=
        internal_operator_in_xatlas(
            (ifx true { temporary___g5: Vector3 = internal_operator(
            (ifx true { temporary___g6: Vector3 = internal_operator(p1, p2); *temporary___g6; }),
            L1
        ); *temporary___g5; }),
            L0 + L1 + L2
        );
    M2 :=
        internal_operator_in_xatlas(
            (ifx true { temporary___g7: Vector3 = internal_operator(
            (ifx true { temporary___g8: Vector3 = internal_operator(p2, p0); *temporary___g8; }),
            L2
        ); *temporary___g7; }),
            L0 + L1 + L2
        );
    return internal_operator((ifx true { temporary___g9: Vector3 = internal_operator(*M0, *M1); *temporary___g9; }), *M2);
}

index_explicit_11 :: (using array: *Array(*Clustered_Charts_Chart), index: u32) -> **Clustered_Charts_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Clustered_Charts_Chart) base.buffer)[index];
}

back :: (using array: *Array(u32)) -> *u32 {
    assert(!is_empty(array));
    return *(cast(*u32) base.buffer)[base.size - 1];
}

internal_min3 :: (a: *float32, b: *float32, c_: *float32) -> float32 {
    return internal_min(a, (ifx true { temporary___g0: float32 = internal_min(b, c_); *temporary___g0; }));
}

internal_normalize_safe :: (v: *Vector2, fallback: *Vector2) -> Vector2 {
    L := internal_length(v);
    if L > 0.0 {
        return internal_operator(v, 1.0 / L);
    }
    return fallback.*;
}

internal_length :: (v: *Vector2) -> float32 {
    return sqrtf(internal_length_squared(v));
}

internal_length_squared :: (v: *Vector2) -> float32 {
    return v.x * v.x + v.y * v.y;
}

vertex_at :: (using uniform_grid2: *Uniform_Grid2, index: u32) -> u32 {
    return ifx indices.length > 0 then ((cast(**u32) *(index_explicit_12(*indices, index))).*).* else index;
}

index_explicit_12 :: (using const_array_view: *Const_Array_View(u32), index: u32) -> *u32 {
    assert(index < length);
    return *data[index];
}

index_explicit_13 :: (using const_array_view: *Const_Array_View(Vector2), index: u32) -> *Vector2 {
    assert(index < length);
    return *data[index];
}

size :: (using array: *Array(s32)) -> u32 {
    return base.size;
}

internal_normalize :: (v: *Vector2) -> Vector2 {
    L := internal_length(v);
    assert(L > 0.0);
    N := internal_operator(v, 1.0 / L);
    assert(internal_is_normalized(*N, K_NORMAL_EPSILON));
    return N;
}

internal_is_normalized :: (v: *Vector2, epsilon_2: float32) -> bool {
    return internal_equal(internal_length(v), 1, epsilon_2);
}

compute_centroid :: (points: Const_Array_View(Vector3)) -> Vector3 {
    local_points: Const_Array_View(Vector3) = points;
    centroid_2: Vector3 = make_vector3(0.0);
    {
        i: u32 = 0;
        while i < local_points.length {
            add_assign(*centroid_2, index_explicit_14(*local_points, i));
            i += 1;
        }
    }
    divide_assign(*centroid_2, cast,no_check(float32) local_points.length);
    return centroid_2;
}

divide_assign :: (using vector3: *Vector3, s: float32) {
    is := 1.0 / s;
    x *= is;
    y *= is;
    z *= is;
}

index_explicit_14 :: (using const_array_view: *Const_Array_View(Vector3), index: u32) -> *Vector3 {
    assert(index < length);
    return *data[index];
}

add_assign :: (using vector3: *Vector3, v: *Vector3) {
    x += v.x;
    y += v.y;
    z += v.z;
}

centroid :: (using aabb: *AABB) -> Vector3 {
    return internal_operator(
        *min,
        (ifx true { temporary___g1: Vector3 = internal_operator(
        (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(*max, *min); *temporary___g0; }),
        0.5
    ); *temporary___g1; })
    );
}

index_explicit_15 :: (using array: *Array(AABB), index: u32) -> *AABB {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*AABB) base.buffer)[index];
}

is_empty :: (using array: *Array(*Uv_Mesh_Instance)) -> bool {
    return base.size == 0;
}

is_empty :: (using array: *Array(*Internal_Mesh)) -> bool {
    return base.size == 0;
}

get_chart :: (using atlas: *Pack_Atlas, index: u32) -> *Pack_Chart {
    return (cast(**Pack_Chart) index_explicit_16(*charts, index)).*;
}

index_explicit_16 :: (using array: *Array(*Pack_Chart), index: u32) -> **Pack_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Pack_Chart) base.buffer)[index];
}

size :: (using array: *Array(*Uv_Mesh_Chart)) -> u32 {
    return base.size;
}

index_explicit_17 :: (using array: *Array(*Uv_Mesh_Instance), index: u32) -> **Uv_Mesh_Instance {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Uv_Mesh_Instance) base.buffer)[index];
}

data :: (using array: *Array(u32)) -> *u32 {
    return cast(*u32) base.buffer;
}

index_explicit_18 :: (using array: *Array(Vector2), index: u32) -> *Vector2 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Vector2) base.buffer)[index];
}

size :: (using array: *Array(*Uv_Mesh_Instance)) -> u32 {
    return base.size;
}

original_vertex_count :: (using chart: *Param_Chart) -> u32 {
    return original_vertex_count;
}

chart_at :: (using chart_group: *Chart_Group, i: u32) -> *Param_Chart {
    return (cast(**Param_Chart) index_explicit_19(*charts, i)).*;
}

index_explicit_19 :: (using array: *Array(*Param_Chart), index: u32) -> **Param_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Param_Chart) base.buffer)[index];
}

chart_group_at :: (using atlas: *Param_Atlas, mesh: u32, group: u32) -> *Chart_Group {
    return (cast(**Chart_Group) index_explicit_21(index_explicit_20(*mesh_chart_groups, mesh), group)).*;
}

index_explicit_20 :: (using array: *Array(Array(*Chart_Group)), index: u32) -> *Array(*Chart_Group) {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Array(*Chart_Group)) base.buffer)[index];
}

index_explicit_21 :: (using array: *Array(*Chart_Group), index: u32) -> **Chart_Group {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Chart_Group) base.buffer)[index];
}

map_face_to_source_face :: (using chart: *Param_Chart, i: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*face_to_source_face_map, i))).*).*;
}

index_explicit_22 :: (using array: *Array(*Mesh_Polygon_Mapping), index: u32) -> **Mesh_Polygon_Mapping {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Mesh_Polygon_Mapping) base.buffer)[index];
}

set :: (using bit_array: *Bit_Array, index: u32) {
    assert(index < size);
    c_transpiler_compound_or(*(((cast(**u32) *(index_explicit(*word_array, index >> 5))).*).*), (cast,no_check(u32) ((cast(s32) 1) << (index & 31))), u32, u32);
}

get :: (using bit_array: *Bit_Array, index: u32) -> bool {
    assert(index < size);
    return (((cast(**u32) *(index_explicit_7(*word_array, index >> 5))).*).* & cast,no_check(u32) ((cast(s32) 1) << (index & 31))) != 0;
}

zero_out_memory :: (using bit_array: *Bit_Array) {
    zero_out_memory(*word_array);
}

zero_out_memory :: (using array: *Array(u32)) {
    if base.buffer != null && base.size > 0 {
        fill_memory(base.buffer, 0, cast,no_check(u64) (base.element_size * base.size));
    }
}

type :: (using chart: *Param_Chart) -> Chart_Type {
    return type;
}

is_invalid :: (using chart: *Param_Chart) -> bool {
    return is_invalid;
}

original_vertices :: (using chart: *Param_Chart) -> Const_Array_View(u32) {
    return make_struct_xatlas_internal_const_array_view_unsigned_int(*original_indices);
}

map_chart_vertex_to_source_vertex :: (using chart: *Param_Chart, i: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*vertex_to_source_vertex_map, i))).*).*;
}

original_vertex_to_unified_vertex :: (using chart: *Param_Chart, v: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*chart_vertex_to_unified_vertex_map, v))).*).*;
}

texcoord_2 :: (using mesh: *Internal_Mesh, vertex: u32) -> *Vector2 {
    return index_explicit_18(*texcoords, vertex);
}

unified_mesh :: (using chart: *Param_Chart) -> *Internal_Mesh {
    return unified_mesh;
}

face_count :: (using mesh: *Internal_Mesh) -> u32 {
    return size(*indices) / 3;
}

chart_count :: (using chart_group: *Chart_Group) -> u32 {
    return size(*charts);
}

size :: (using array: *Array(*Param_Chart)) -> u32 {
    return base.size;
}

chart_group_count :: (using atlas: *Param_Atlas, mesh: u32) -> u32 {
    return size(index_explicit_20(*mesh_chart_groups, mesh));
}

size :: (using array: *Array(*Chart_Group)) -> u32 {
    return base.size;
}

index_explicit_23 :: (using array: *Array(u8), index: u32) -> *u8 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *base.buffer[index];
}

size :: (using array: *Array(u8)) -> u32 {
    return base.size;
}

resize :: (using bit_array: *Bit_Array, new_size: u32) {
    size = new_size;
    resize(*word_array, (size + 31) >> 5);
}

resize :: (using array: *Array(u32), new_size: u32) {
    resize(*base, new_size, true);
}

size_2 :: (using array: *Array(*Internal_Mesh)) -> u32 {
    return base.size;
}

get_images :: (using atlas: *Pack_Atlas) -> *Array(*Atlas_Image) {
    return *atlas_images;
}

index_explicit_24 :: (using array: *Array(*Atlas_Image), index: u32) -> **Atlas_Image {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Atlas_Image) base.buffer)[index];
}

copy_to :: (using atlas_image: *Atlas_Image, dest: *u32, dest_width: u32, dest_height: u32, padding: s32) {
    if 0 < dest_height {
        for y: 0..dest_height - 1 {
            copy_memory(
                *dest[y * dest_width],
                (cast(**u32) *(index_explicit_7(*data, (cast,no_check(u32) padding) +
                (y + cast,no_check(u32) padding) * width))).*,
                (cast(u64) dest_width) * 4
            );
        }
    }
}

get_utilization :: (using atlas_2: *Pack_Atlas, atlas: u32) -> float32 {
    return ((cast(**float32) *(index_explicit_25(*utilization, atlas))).*).*;
}

index_explicit_25 :: (using array: *Array(float32), index: u32) -> *float32 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*float32) base.buffer)[index];
}

get_texels_per_unit :: (using atlas: *Pack_Atlas) -> float32 {
    return texels_per_unit;
}

get_height :: (using atlas: *Pack_Atlas) -> u32 {
    return height;
}

get_width :: (using atlas: *Pack_Atlas) -> u32 {
    return width;
}

get_chart_count :: (using atlas: *Pack_Atlas) -> u32 {
    return size(*charts);
}

get_num_atlases :: (using atlas: *Pack_Atlas) -> u32 {
    return size(*bit_images);
}

size :: (using array: *Array(*Bit_Image)) -> u32 {
    return base.size;
}

pack_charts :: (
    atlas: *Pack_Atlas,
    options_: *Pack_Options,
    progress_func: Progress_Func,
    progress_user_data: *void
) -> bool {
    if progress_func != null {
        if !progress_func(PROGRESS_CATEGORY_PACK_CHARTS, 0, progress_user_data) {
            return false;
        }
    }
    CHART_COUNT := size(*atlas.charts);
    if s_print != null && s_print_verbose {
        s_print(c_string("Packing %u charts\n"), CHART_COUNT);
    }

    if CHART_COUNT == 0 {
        if progress_func != null {
            if !progress_func(PROGRESS_CATEGORY_PACK_CHARTS, 100, progress_user_data) {
                return false;
            }
        }
        return true;
    }

    atlas.texels_per_unit = options_.texels_per_unit;
    resolution := (ifx options_.resolution > 0 then options_.resolution + options_.padding * 2 else 0);
    MAX_RESOLUTION := (ifx atlas.texels_per_unit > 0.0 then resolution else 0);
    if resolution <= 0 || atlas.texels_per_unit <= 0 {
        if resolution <= 0 && atlas.texels_per_unit <= 0 {
            resolution = 1024;
        }
        mesh_area: float32 = 0;
        if 0 < CHART_COUNT {
            for c___: 0..CHART_COUNT - 1 {
                mesh_area += ((cast(**Pack_Chart) index_explicit_3(*atlas.charts, c___)).*).surface_area;
            }
        }
        if resolution <= 0 {
            TEXEL_COUNT_2 :=
                internal_max(
                    (ifx true { temporary___g0: float32 = 1.0; *temporary___g0; }),
                    (ifx true { temporary___g1: float32 = (mesh_area *
                    internal_square(atlas.texels_per_unit) / 0.75); *temporary___g1; })
                );
            (ifx true { assignment_0: u32 = cast,no_check(u32) (internal_max(
                (ifx true { temporary___g2: u32 = cast(u32) 1; *temporary___g2; }),
                (ifx true { temporary___g4: u32 = internal_next_power_of_two(cast,no_check(u32) sqrtf(TEXEL_COUNT_2)); *temporary___g4; })
            )); (resolution) = assignment_0; assignment_0; });
        }
        if atlas.texels_per_unit <= 0 {
            TEXEL_COUNT :=
                internal_max(
                    (ifx true { temporary___g3: float32 = 1.0; *temporary___g3; }),
                    (ifx true { temporary___g6: float32 = (mesh_area / 0.75); *temporary___g6; })
                );
            atlas.texels_per_unit = sqrtf((resolution * resolution) / TEXEL_COUNT);
            if s_print != null && s_print_verbose {
                s_print(c_string("   Estimating texelsPerUnit as %g\n"), cast,no_check(float64) atlas.texels_per_unit);
            }
        }
    }
    chart_order_array: Array(float32) = ---;
    defer deinit(*chart_order_array);
    init(*chart_order_array, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*chart_order_array, CHART_COUNT);
    chart_extents: Array(Vector2) = ---;
    defer deinit(*chart_extents);
    init(*chart_extents, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*chart_extents, CHART_COUNT);
    min_chart_perimeter: float32 = cast(float32) 3.40282347e+38;
    max_chart_perimeter: float32 = 0.0;
    {
        c__: u32 = 0;
        while c__ < CHART_COUNT {
            chart_2: *Pack_Chart =
                cast,no_check(*Pack_Chart) ((cast(**Pack_Chart) index_explicit_3(*atlas.charts, c__)).*);

            scale: float32 = 1.0;
            if chart_2.parametric_area != 0.0 {
                scale = sqrtf(chart_2.surface_area / chart_2.parametric_area) * atlas.texels_per_unit;
                if !internal_is_finite(scale) {
                    if s_print != null {
                        s_print(
                            c_string("\rASSERT: %s %s %d\n"),
                            c_string("isFinite(scale)"),
                            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                            cast(s32) 8319
                        );
                    }
                }
            }

            min_corner: Vector2 = make_vector2(cast(float32) 3.40282347e+38, cast(float32) 3.40282347e+38);
            if !options_.rotate_charts_to_axis {
                {
                    i_5: u32 = 0;
                    while i_5 < unique_vertex_count(chart_2) {
                        assign(
                            *min_corner,
                            (ifx true { temporary___g5: Vector2 = internal_min(*min_corner, unique_vertex_at(chart_2, i_5)); *temporary___g5; })
                        );
                        i_5 += 1;
                    }
                }
            }
            extents: Vector2 = make_vector2(0.0);
            {
                i_4: u32 = 0;
                while i_4 < unique_vertex_count(chart_2) {
                    texcoord_7: *Vector2 = cast,no_check(*Vector2) unique_vertex_at(chart_2, i_4);
                    if options_.rotate_charts_to_axis {
                        X := internal_dot(texcoord_7, *chart_2.major_axis);
                        Y := internal_dot(texcoord_7, *chart_2.minor_axis);
                        texcoord_7.x = X;
                        texcoord_7.y = Y;
                        subtract_assign(texcoord_7, *chart_2.min_corner);
                    } else {
                        subtract_assign(texcoord_7, *min_corner);
                    }
                    multiply_assign(texcoord_7, scale);
                    assert(texcoord_7.x >= 0.0 && texcoord_7.y >= 0.0);
                    assert(internal_is_finite(texcoord_7.x) && internal_is_finite(texcoord_7.y));
                    assign(
                        *extents,
                        (ifx true { temporary___g8: Vector2 = internal_max(*extents, texcoord_7); *temporary___g8; })
                    );
                    i_4 += 1;
                }
            }
            assert(extents.x >= 0 && extents.y >= 0);

            if extents.x > 0.0 && extents.y > 0.0 {
                BLOCK_ALIGN_SIZE_OFFSET := cast,no_check(s32) ((options_.padding * 2) + 1);
                _width := internal_ftoi_ceil(extents.x);
                if options_.block_align {
                    _width = internal_align(_width + BLOCK_ALIGN_SIZE_OFFSET, 4) - BLOCK_ALIGN_SIZE_OFFSET;
                }
                _height := internal_ftoi_ceil(extents.y);
                if options_.block_align {
                    _height = internal_align(_height + BLOCK_ALIGN_SIZE_OFFSET, 4) - BLOCK_ALIGN_SIZE_OFFSET;
                }
                {
                    v_4: u32 = 0;
                    while v_4 < unique_vertex_count(chart_2) {
                        texcoord_6: *Vector2 = cast,no_check(*Vector2) unique_vertex_at(chart_2, v_4);
                        texcoord_6.x = texcoord_6.x / extents.x * cast,no_check(float32) _width;
                        texcoord_6.y = texcoord_6.y / extents.y * cast,no_check(float32) _height;
                        v_4 += 1;
                    }
                }
                extents.x = cast,no_check(float32) _width;
                extents.y = cast,no_check(float32) _height;
            }

            max_chart_size := options_.max_chart_size;
            warn_chart_resized: bool = false;
            if MAX_RESOLUTION > 0 && (max_chart_size == 0 || MAX_RESOLUTION < max_chart_size) {
                max_chart_size = MAX_RESOLUTION - options_.padding * 2;
                warn_chart_resized = true;
            }
            if max_chart_size > 0 {
                REAL_MAX_CHART_SIZE := (cast,no_check(float32) max_chart_size) - 1.0;
                if extents.x > REAL_MAX_CHART_SIZE || extents.y > REAL_MAX_CHART_SIZE {
                    if warn_chart_resized {
                        if s_print != null && s_print_verbose {
                            s_print(
                                c_string("   Resizing chart %u from %gx%g to %ux%u to fit atlas\n"),
                                c__,
                                cast,no_check(float64) extents.x,
                                cast,no_check(float64) extents.y,
                                max_chart_size,
                                max_chart_size
                            );
                        }
                    }

                    scale = REAL_MAX_CHART_SIZE / internal_max(*extents.x, *extents.y);
                    {
                        i_3: u32 = 0;
                        while i_3 < unique_vertex_count(chart_2) {
                            texcoord_5: *Vector2 = cast,no_check(*Vector2) unique_vertex_at(chart_2, i_3);
                            assign(
                                texcoord_5,
                                (ifx true { temporary___g10: Vector2 = internal_min(
                                (ifx true { temporary___g7: Vector2 = internal_operator(texcoord_5, scale); *temporary___g7; }),
                                (ifx true { temporary___g9: Vector2 = make_vector2(REAL_MAX_CHART_SIZE); *temporary___g9; })
                            ); *temporary___g10; })
                            );
                            i_3 += 1;
                        }
                    }
                }
            }

            extents.y = 0.0;
            extents.x = extents.y;
            {
                v_3: u32 = 0;
                while v_3 < unique_vertex_count(chart_2) {
                    texcoord_4: *Vector2 = cast,no_check(*Vector2) unique_vertex_at(chart_2, v_3);
                    texcoord_4.x += 0.5 + options_.padding;
                    texcoord_4.y += 0.5 + options_.padding;
                    assign(
                        *extents,
                        (ifx true { temporary___g11: Vector2 = internal_max(*extents, texcoord_4); *temporary___g11; })
                    );
                    v_3 += 1;
                }
            }
            if extents.x > cast,no_check(float32) resolution || extents.y > cast,no_check(float32) resolution {
                if s_print != null && s_print_verbose {
                    s_print(
                        c_string("   Chart %u extents are large (%gx%g)\n"),
                        c__,
                        cast,no_check(float64) extents.x,
                        cast,no_check(float64) extents.y
                    );
                }
            }

            assign_3(index_explicit_4(*chart_extents, c__), *extents);
            assignment_1: float32 = (extents.x + extents.y);
            (((cast(**float32) *(index_explicit_26(*chart_order_array, c__))).*).*) = assignment_1;
            min_chart_perimeter = internal_min(*min_chart_perimeter, index_explicit_26(*chart_order_array, c__));
            max_chart_perimeter = internal_max(*max_chart_perimeter, index_explicit_26(*chart_order_array, c__));
            c__ += 1;
        }
    }

    sort(*atlas.radix, make_struct_xatlas_internal_const_array_view_float(*chart_order_array));
    ranks_2 := ranks(*atlas.radix);

    CHART_PERIMETER_BUCKET_SIZE := (max_chart_perimeter - min_chart_perimeter) / 16.0;
    current_chart_bucket: u32 = 0;
    chart_start_positions: Array(Vector2i) = ---;
    defer deinit(*chart_start_positions);
    init(*chart_start_positions, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    push_back(*chart_start_positions, (ifx true { temporary___g12: Vector2i = make_vector2i(0, 0); *temporary___g12; }));

    CREATE_IMAGE := options_.create_image;

    chart_image: Bit_Image = ---;
    defer deinit(*chart_image);
    init(*chart_image);
    chart_image_bilinear: Bit_Image = ---;
    defer deinit(*chart_image_bilinear);
    init(*chart_image_bilinear);
    chart_image_padding: Bit_Image = ---;
    defer deinit(*chart_image_padding);
    init(*chart_image_padding);
    chart_image_rotated: Bit_Image = ---;
    defer deinit(*chart_image_rotated);
    init(*chart_image_rotated);
    chart_image_bilinear_rotated: Bit_Image = ---;
    defer deinit(*chart_image_bilinear_rotated);
    init(*chart_image_bilinear_rotated);
    chart_image_padding_rotated: Bit_Image = ---;
    defer deinit(*chart_image_padding_rotated);
    init(*chart_image_padding_rotated);
    boundary_edge_grid: Uniform_Grid2 = ---;
    defer deinit(*boundary_edge_grid);
    init(*boundary_edge_grid);
    atlas_sizes: Array(Vector2i) = ---;
    defer deinit(*atlas_sizes);
    init(*atlas_sizes, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    push_back(*atlas_sizes, (ifx true { temporary___g13: Vector2i = make_vector2i(0, 0); *temporary___g13; }));
    progress: s32 = 0;
    if 0 < CHART_COUNT {
        for i: 0..CHART_COUNT - 1 {
            c_ := ranks_2[CHART_COUNT - i - 1];
            chart: *Pack_Chart =
                cast,no_check(*Pack_Chart) ((cast(**Pack_Chart) index_explicit_3(*atlas.charts, c_)).*);

            resize(
                *chart_image,
                (cast,no_check(u32) internal_ftoi_ceil((index_explicit_4(*chart_extents, c_)).x)) + options_.padding,
                (cast,no_check(u32) internal_ftoi_ceil((index_explicit_4(*chart_extents, c_)).y)) + options_.padding,
                true
            );
            if options_.rotate_charts {
                resize(*chart_image_rotated, height(*chart_image), width(*chart_image), true);
            }
            if options_.bilinear {
                resize(*chart_image_bilinear, width(*chart_image), height(*chart_image), true);
                if options_.rotate_charts {
                    resize(*chart_image_bilinear_rotated, height(*chart_image), width(*chart_image), true);
                }
            }

            FACE_COUNT := chart.indices.length / 3;
            if 0 < FACE_COUNT {
                for f: 0..FACE_COUNT - 1 {
                    vertices_2: [3] Vector2 = ---;
                    {
                        cpp_transpiler_fixed_array_index_g14: u64 = 0;
                        while cpp_transpiler_fixed_array_index_g14 < 3 {
                            init(*vertices_2[cpp_transpiler_fixed_array_index_g14]);
                            cpp_transpiler_fixed_array_index_g14 += 1;
                        }
                    }
                    for v_2: 0..cast(u32) 3 - 1 {
                        assign_3(
                            vertices_2.data + v_2,
                            index_explicit_2(
                            *chart.vertices,
                            ((cast(**u32) *(index_explicit_12(*chart.indices, (f * 3) + v_2))).*).*
                        )
                        );
                    }
                    args: Atlas_Draw_Triangle_Callback_Args = ---;
                    args.chart_bit_image = *chart_image;
                    args.chart_bit_image_rotated =
                        ifx options_.rotate_charts then *chart_image_rotated else cast(*Bit_Image) null;
                    internal_raster_draw_triangle(
                        (ifx true { temporary___g15: Vector2 = make_vector2(
                        cast,no_check(float32) width(*chart_image),
                        cast,no_check(float32) height(*chart_image)
                    ); *temporary___g15; }),
                        vertices_2.data,
                        cast,no_check(Sampling_Callback) draw_triangle_callback,
                        cast(*void) *args
                    );
                }
            }

            if options_.bilinear {
                bilinear_expand(
                    atlas,
                    chart,
                    *chart_image,
                    *chart_image_bilinear,
                    (ifx options_.rotate_charts then *chart_image_bilinear_rotated else cast(*Bit_Image) null),
                    *boundary_edge_grid
                );
            }

            if options_.padding > 0 {
                if options_.bilinear {
                    copy_to(*chart_image_bilinear, *chart_image_padding);
                } else {
                    copy_to(*chart_image, *chart_image_padding);
                }
                dilate(*chart_image_padding, options_.padding);
                if options_.rotate_charts {
                    if options_.bilinear {
                        copy_to(*chart_image_bilinear_rotated, *chart_image_padding_rotated);
                    } else {
                        copy_to(*chart_image_rotated, *chart_image_padding_rotated);
                    }
                    dilate(*chart_image_padding_rotated, options_.padding);
                }
            }

            if options_.brute_force {
                if ((cast(**float32) *(index_explicit_26(*chart_order_array, c_))).*).* > min_chart_perimeter &&
                    ((cast(**float32) *(index_explicit_26(*chart_order_array, c_))).*).* <= max_chart_perimeter - CHART_PERIMETER_BUCKET_SIZE * (current_chart_bucket + 1) {
                    {
                        j_2: u32 = 0;
                        while j_2 < size(*chart_start_positions) {
                            assign_2(
                                index_explicit_29(*chart_start_positions, j_2),
                                (ifx true { temporary___g16: Vector2i = make_vector2i(0, 0); *temporary___g16; })
                            );
                            j_2 += 1;
                        }
                    }
                    current_chart_bucket += 1;
                }
            }

            chart_image_to_pack, chart_image_to_pack_rotated: *Bit_Image = ---;
            if options_.padding > 0 {
                chart_image_to_pack = *chart_image_padding;
                chart_image_to_pack_rotated = *chart_image_padding_rotated;
            } else if options_.bilinear {
                chart_image_to_pack = *chart_image_bilinear;
                chart_image_to_pack_rotated = *chart_image_bilinear_rotated;
            } else {
                chart_image_to_pack = *chart_image;
                chart_image_to_pack_rotated = *chart_image_rotated;
            }
            current_atlas: u32 = 0;
            best_x: s32 = 0;
            best_y: s32 = 0;
            best_cw: s32 = 0;
            best_ch: s32 = 0;
            best_r: s32 = 0;
            while true {
                first_chart_in_bit_image: bool = false;

                if (current_atlas + 1) > size(*atlas.bit_images) {
                    bi :=
                        cast(*Bit_Image) (cast(*void) (cast(*Bit_Image) internal_realloc(
                            null,
                            40,
                            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                            8513
                        )));
                    init(bi, resolution, resolution);
                    push_back(*atlas.bit_images, *bi);
                    push_back(
                        *atlas_sizes,
                        (ifx true { temporary___g17: Vector2i = make_vector2i(0, 0); *temporary___g17; })
                    );

                    first_chart_in_bit_image = true;

                    if CREATE_IMAGE {
                        push_back(
                            *atlas.atlas_images,
                            (ifx true { temporary___g18: *Atlas_Image = (ifx true {
    cpp_transpiler_new_g19 :=
        cast(*Atlas_Image) (cast(*void) (cast(*Atlas_Image) internal_realloc(
            null,
            32,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            8520
        )));
    init(cpp_transpiler_new_g19, resolution, resolution);
    cpp_transpiler_new_g19;
})
; *temporary___g18; })
                        );
                    }

                    push_back(
                        *chart_start_positions,
                        (ifx true { temporary___g20: Vector2i = make_vector2i(0, 0); *temporary___g20; })
                    );
                }

                FOUND_LOCATION :=
                    find_chart_location(
                        atlas,
                        options_,
                        index_explicit_29(*chart_start_positions, current_atlas),
                        (cast(**Bit_Image) index_explicit_28(*atlas.bit_images, current_atlas)).*,
                        chart_image_to_pack,
                        chart_image_to_pack_rotated,
                        (index_explicit_29(*atlas_sizes, current_atlas)).x,
                        (index_explicit_29(*atlas_sizes, current_atlas)).y,
                        *best_x,
                        *best_y,
                        *best_cw,
                        *best_ch,
                        *best_r,
                        MAX_RESOLUTION
                    );

                assert(!(first_chart_in_bit_image && !FOUND_LOCATION));
                if MAX_RESOLUTION == 0 {
                    assert(FOUND_LOCATION);
                    break;
                }
                if FOUND_LOCATION {
                    break;
                }

                current_atlas += 1;
            }

            if options_.brute_force {
                if best_x + best_cw > (index_explicit_29(*atlas_sizes, current_atlas)).x ||
                    best_y + best_ch > (index_explicit_29(*atlas_sizes, current_atlas)).y {
                    {
                        j: u32 = 0;
                        while j < size(*chart_start_positions) {
                            assign_2(
                                index_explicit_29(*chart_start_positions, j),
                                (ifx true { temporary___g21: Vector2i = make_vector2i(0, 0); *temporary___g21; })
                            );
                            j += 1;
                        }
                    }
                } else {
                    assign_2(
                        index_explicit_29(*chart_start_positions, current_atlas),
                        (ifx true { temporary___g22: Vector2i = make_vector2i(best_x, best_y); *temporary___g22; })
                    );
                }
            }

            (ifx true { assignment_2: s32 = cast,no_check(s32) (internal_max(
                *((index_explicit_29(*atlas_sizes, current_atlas)).x),
                (ifx true { temporary___g23: s32 = (best_x + best_cw); *temporary___g23; })
            )); ((index_explicit_29(*atlas_sizes, current_atlas)).x) = assignment_2; assignment_2; });
            (ifx true { assignment_3: s32 = cast,no_check(s32) (internal_max(
                *((index_explicit_29(*atlas_sizes, current_atlas)).y),
                (ifx true { temporary___g24: s32 = (best_y + best_ch); *temporary___g24; })
            )); ((index_explicit_29(*atlas_sizes, current_atlas)).y) = assignment_3; assignment_3; });

            if MAX_RESOLUTION == 0 {
                W := cast,no_check(u32) ((index_explicit_29(*atlas_sizes, current_atlas)).x);
                H := cast,no_check(u32) ((index_explicit_29(*atlas_sizes, current_atlas)).y);
                if W > width((cast(**Bit_Image) index_explicit_28(*atlas.bit_images, 0)).*) ||
                    H > height((cast(**Bit_Image) index_explicit_28(*atlas.bit_images, 0)).*) {
                    resize(
                        (cast(**Bit_Image) index_explicit_28(*atlas.bit_images, 0)).*,
                        internal_next_power_of_two(W),
                        internal_next_power_of_two(H),
                        false
                    );
                    if CREATE_IMAGE {
                        resize(
                            (cast(**Atlas_Image) index_explicit_30(*atlas.atlas_images, 0)).*,
                            width((cast(**Bit_Image) index_explicit_28(*atlas.bit_images, 0)).*),
                            height((cast(**Bit_Image) index_explicit_28(*atlas.bit_images, 0)).*)
                        );
                    }
                }
            } else {
                assert((index_explicit_29(*atlas_sizes, current_atlas)).x <= cast,no_check(s32) MAX_RESOLUTION);
                assert((index_explicit_29(*atlas_sizes, current_atlas)).y <= cast,no_check(s32) MAX_RESOLUTION);
            }

            add_chart(
                atlas,
                (cast(**Bit_Image) index_explicit_28(*atlas.bit_images, current_atlas)).*,
                chart_image_to_pack,
                chart_image_to_pack_rotated,
                (index_explicit_29(*atlas_sizes, current_atlas)).x,
                (index_explicit_29(*atlas_sizes, current_atlas)).y,
                best_x,
                best_y,
                best_r
            );

            if CREATE_IMAGE {
                if best_r == 0 {
                    add_chart(
                        (cast(**Atlas_Image) index_explicit_30(*atlas.atlas_images, current_atlas)).*,
                        c_,
                        *chart_image,
                        (ifx options_.bilinear then *chart_image_bilinear else cast(*Bit_Image) null),
                        (ifx options_.padding > 0 then *chart_image_padding else cast(*Bit_Image) null),
                        (index_explicit_29(*atlas_sizes, current_atlas)).x,
                        (index_explicit_29(*atlas_sizes, current_atlas)).y,
                        best_x,
                        best_y
                    );
                } else {
                    add_chart(
                        (cast(**Atlas_Image) index_explicit_30(*atlas.atlas_images, current_atlas)).*,
                        c_,
                        *chart_image_rotated,
                        (ifx options_.bilinear then *chart_image_bilinear_rotated else cast(*Bit_Image) null),
                        (ifx options_.padding > 0 then *chart_image_padding_rotated else cast(*Bit_Image) null),
                        (index_explicit_29(*atlas_sizes, current_atlas)).x,
                        (index_explicit_29(*atlas_sizes, current_atlas)).y,
                        best_x,
                        best_y
                    );
                }
            }
            chart.atlas_index = cast,no_check(s32) current_atlas;

            {
                v: u32 = 0;
                while v < unique_vertex_count(chart) {
                    texcoord_3: *Vector2 = cast,no_check(*Vector2) unique_vertex_at(chart, v);
                    t := texcoord_3.*;
                    if best_r != 0 {
                        assert(options_.rotate_charts);
                        internal_swap(*t.x, *t.y);
                    }
                    texcoord_3.x = best_x + t.x;
                    texcoord_3.y = best_y + t.y;
                    texcoord_3.x -= cast,no_check(float32) options_.padding;
                    texcoord_3.y -= cast,no_check(float32) options_.padding;
                    if !(texcoord_3.x >= 0 && texcoord_3.y >= 0) {
                        if s_print != null {
                            s_print(
                                c_string("\rASSERT: %s %s %d\n"),
                                c_string("texcoord.x >= 0 && texcoord.y >= 0"),
                                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                                cast(s32) 8598
                            );
                        }
                    }
                    if !(internal_is_finite(texcoord_3.x) && internal_is_finite(texcoord_3.y)) {
                        if s_print != null {
                            s_print(
                                c_string("\rASSERT: %s %s %d\n"),
                                c_string("isFinite(texcoord.x) && isFinite(texcoord.y)"),
                                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                                cast(s32) 8599
                            );
                        }
                    }
                    v += 1;
                }
            }
            if progress_func != null {
                NEW_PROGRESS := cast,no_check(s32) (((i + 1) / cast,no_check(float32) CHART_COUNT) * 100.0);
                if NEW_PROGRESS != progress {
                    progress = NEW_PROGRESS;
                    if !progress_func(PROGRESS_CATEGORY_PACK_CHARTS, progress, progress_user_data) {
                        return false;
                    }
                }
            }
        }
    }

    if MAX_RESOLUTION == 0 {
        (ifx true { assignment_4: u32 = cast,no_check(u32) (cast,no_check(u32) internal_max(
            (ifx true { temporary___g25: s32 = cast(s32) 0; *temporary___g25; }),
            (ifx true { temporary___g26: s32 = ((index_explicit_29(*atlas_sizes, 0)).x -
            (cast,no_check(s32) options_.padding) * 2); *temporary___g26; })
        )); (atlas.width) = assignment_4; assignment_4; });
        (ifx true { assignment_5: u32 = cast,no_check(u32) (cast,no_check(u32) internal_max(
            (ifx true { temporary___g27: s32 = cast(s32) 0; *temporary___g27; }),
            (ifx true { temporary___g28: s32 = ((index_explicit_29(*atlas_sizes, 0)).y -
            (cast,no_check(s32) options_.padding) * 2); *temporary___g28; })
        )); (atlas.height) = assignment_5; assignment_5; });
    } else {
        atlas.height = (MAX_RESOLUTION - cast,no_check(u32) ((cast,no_check(s32) options_.padding) * 2));
        atlas.width = atlas.height;
    }
    if s_print != null && s_print_verbose {
        s_print(c_string("   %dx%d resolution\n"), atlas.width, atlas.height);
    }

    resize(*atlas.utilization, size(*atlas.bit_images));
    {
        i_2: u32 = 0;
        while i_2 < size(*atlas.utilization) {
            if atlas.width == 0 || atlas.height == 0 {
                ((cast(**float32) *(index_explicit_26(*atlas.utilization, i_2))).*).* = 0.0;
            } else {
                count_2: u32 = 0;
                {
                    y: u32 = 0;
                    while y < atlas.height {
                        {
                            x: u32 = 0;
                            while x < atlas.width {
                                count_2 +=
                                    cast(u32) get(
                                        (cast(**Bit_Image) index_explicit_28(*atlas.bit_images, i_2)).*,
                                        x,
                                        y
                                    );
                                x += 1;
                            }
                        }
                        y += 1;
                    }
                }
                assignment_6: float32 = ((cast,no_check(float32) count_2) / (atlas.width * atlas.height));
                (((cast(**float32) *(index_explicit_26(*atlas.utilization, i_2))).*).*) = assignment_6;
            }
            if size(*atlas.utilization) > 1 {
                if s_print != null && s_print_verbose {
                    s_print(
                        c_string("   %u: %f%% utilization\n"),
                        i_2,
                        cast,no_check(float64) (((cast(**float32) *(index_explicit_26(*atlas.utilization, i_2))).*).* *
                        100.0)
                    );
                }
            } else {
                if s_print != null && s_print_verbose {
                    s_print(
                        c_string("   %f%% utilization\n"),
                        cast,no_check(float64) (((cast(**float32) *(index_explicit_26(*atlas.utilization, i_2))).*).* *
                        100.0)
                    );
                }
            }
            i_2 += 1;
        }
    }

    if progress_func != null && progress != 100 {
        if !progress_func(PROGRESS_CATEGORY_PACK_CHARTS, 100, progress_user_data) {
            return false;
        }
    }
    return true;
}

index_explicit_26 :: (using array: *Array(float32), index: u32) -> *float32 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*float32) base.buffer)[index];
}

size :: (using array: *Array(float32)) -> u32 {
    return base.size;
}

get :: (using bit_image: *Bit_Image, x: u32, y: u32) -> bool {
    assert(x < width && y < height);
    INDEX := x >> 6 + y * row_stride;
    return ((cast(**u64) *(index_explicit_27(*data, INDEX))).*).* & ((cast(u64) 1) << ((cast(u64) x) & 63)) != 0;
}

index_explicit_27 :: (using array: *Array(u64), index: u32) -> *u64 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*u64) base.buffer)[index];
}

index_explicit_28 :: (using array: *Array(*Bit_Image), index: u32) -> **Bit_Image {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Bit_Image) base.buffer)[index];
}

resize :: (using array: *Array(float32), new_size: u32) {
    resize(*base, new_size, true);
}

index_explicit_29 :: (using array: *Array(Vector2i), index: u32) -> *Vector2i {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Vector2i) base.buffer)[index];
}

internal_max :: (a: *s32, b: *s32) -> s32 {
    return max(a.*, b.*);
}

internal_is_finite :: (f: float32) -> bool {
    fu: Float_Uint32 = ---;
    fu.f = f;
    return fu.u != 0x7f800000 && fu.u != 0x7f800001;
}

internal_swap :: (a: *float32, b: *float32) {
    temp := a.*;
    assignment_7: float32 = b.*;
    (((cast(**float32) *(a)).*).*) = assignment_7;
    assignment_8: float32 = temp;
    (((cast(**float32) *(b)).*).*) = assignment_8;
}

unique_vertex_count :: (using chart: *Pack_Chart) -> u32 {
    return ifx is_empty(*unique_vertices) then vertices.length else size(*unique_vertices);
}

add_chart :: (
    atlas_image: *Atlas_Image,
    chart_index: u32,
    image: *Bit_Image,
    image_bilinear: *Bit_Image,
    image_padding: *Bit_Image,
    atlas_w: s32,
    atlas_h: s32,
    offset_x: s32,
    offset_y: s32
) {
    W := cast,no_check(s32) width(image);
    H := cast,no_check(s32) height(image);
    if 0 < H {
        for y: 0..H - 1 {
            YY := y + offset_y;
            if YY < 0 {
                continue;
            }
            if 0 < W {
                for x: 0..W - 1 {
                    XX := x + offset_x;
                    if XX >= 0 && XX < atlas_w && YY < atlas_h {
                        DATA_OFFSET := (cast,no_check(u32) XX) + (cast,no_check(u32) YY) * atlas_image.width;
                        if get(image, cast,no_check(u32) x, cast,no_check(u32) y) {
                            assert(((cast(**u32) *(index_explicit(*atlas_image.data, DATA_OFFSET))).*).* == 0);
                            assignment_9: u32 = (chart_index | cast(u32) 0x80000000);
                            (((cast(**u32) *(index_explicit(*atlas_image.data, DATA_OFFSET))).*).*) = assignment_9;
                        } else if image_bilinear != null && get(image_bilinear, cast,no_check(u32) x, cast,no_check(u32) y) {
                            assert(((cast(**u32) *(index_explicit(*atlas_image.data, DATA_OFFSET))).*).* == 0);
                            assignment_10: u32 =
                                ((chart_index | cast(u32) 0x80000000) | cast,no_check(u32) (cast(s32) 0x40000000));
                            (((cast(**u32) *(index_explicit(*atlas_image.data, DATA_OFFSET))).*).*) = assignment_10;
                        } else if image_padding != null && get(image_padding, cast,no_check(u32) x, cast,no_check(u32) y) {
                            assert(((cast(**u32) *(index_explicit(*atlas_image.data, DATA_OFFSET))).*).* == 0);
                            assignment_11: u32 =
                                ((chart_index | cast(u32) 0x80000000) | cast,no_check(u32) (cast(s32) 0x20000000));
                            (((cast(**u32) *(index_explicit(*atlas_image.data, DATA_OFFSET))).*).*) = assignment_11;
                        }
                    }
                }
            }
        }
    }
}

width :: (using bit_image: *Bit_Image) -> u32 {
    return width;
}

height :: (using bit_image: *Bit_Image) -> u32 {
    return height;
}

index_explicit_30 :: (using array: *Array(*Atlas_Image), index: u32) -> **Atlas_Image {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Atlas_Image) base.buffer)[index];
}

add_chart :: (
    atlas: *Pack_Atlas,
    atlas_bit_image: *Bit_Image,
    chart_bit_image: *Bit_Image,
    chart_bit_image_rotated: *Bit_Image,
    atlas_w: s32,
    atlas_h: s32,
    offset_x: s32,
    offset_y: s32,
    r: s32
) {
    assert(r == 0 || r == 1);
    image := (ifx r == 0 then chart_bit_image else chart_bit_image_rotated);
    W := cast,no_check(s32) width(image);
    H := cast,no_check(s32) height(image);
    if 0 < H {
        for y: 0..H - 1 {
            yy := y + offset_y;
            if yy >= 0 {
                if 0 < W {
                    for x: 0..W - 1 {
                        xx_ := x + offset_x;
                        if xx_ >= 0 {
                            if get(image, cast,no_check(u32) x, cast,no_check(u32) y) {
                                if xx_ < atlas_w && yy < atlas_h {
                                    assert(get(atlas_bit_image, cast,no_check(u32) xx_, cast,no_check(u32) yy) == false);
                                    set(atlas_bit_image, cast,no_check(u32) xx_, cast,no_check(u32) yy);
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

set :: (using bit_image: *Bit_Image, x: u32, y: u32) {
    assert(x < width && y < height);
    INDEX := x >> 6 + y * row_stride;
    c_transpiler_compound_or(*(((cast(**u64) *(index_explicit_31(*data, INDEX))).*).*), (((cast(u64) 1) << ((cast(u64) x) & 63))), u64, u64);
    assert(get(bit_image, x, y));
}

index_explicit_31 :: (using array: *Array(u64), index: u32) -> *u64 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*u64) base.buffer)[index];
}

resize :: (atlas_image: *Atlas_Image, _width: u32, _height: u32) {
    _data: Array(u32) = ---;
    defer deinit(*_data);
    init(*_data, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*_data, _width * _height);
    fill_memory(data(*_data), 0, 4 * cast(u64) size(*_data));
    {
        y: u32 = 0;
        while y < internal_min(*atlas_image.height, *_height) {
            copy_memory(
                (cast(**u32) *(index_explicit(*_data, y * _width))).*,
                (cast(**u32) *(index_explicit(*atlas_image.data, y * atlas_image.width))).*,
                (cast(u64) internal_min(*atlas_image.width, *_width)) * 4
            );
            y += 1;
        }
    }
    atlas_image.width = _width;
    atlas_image.height = _height;
    move_to(*_data, *atlas_image.data);
}

move_to :: (using array: *Array(u32), other: *Array(u32)) {
    move_to(*base, *other.base);
}

move_to :: (using array_base: *Array_Base, other: *Array_Base) {
    assert(element_size == other.element_size);
    destroy(other);
    other.buffer = buffer;
    other.element_size = element_size;
    other.size = size;
    other.capacity = capacity;

    buffer = cast(*u8) null;
    capacity = 0;
    size = capacity;
    element_size = size;
}

destroy :: (using array_base: *Array_Base) {
    size = 0;
    internal_realloc(
        cast(*void) buffer,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        990
    );
    buffer = cast(*u8) null;
    capacity = 0;
    size = 0;
}

internal_next_power_of_two :: (x: u32) -> u32 {
    assert(x != 0);

    x -= 1;
    x |= x >> 1;
    x |= x >> 2;
    x |= x >> 4;
    x |= x >> 8;
    x |= x >> 16;
    return x + 1;
}

resize :: (bit_image: *Bit_Image, w: u32, h: u32, discard: bool) {
    ROW_STRIDE := (w + 63) >> 6;
    if discard {
        resize(*bit_image.data, ROW_STRIDE * h);
        zero_out_memory(*bit_image.data);
    } else {
        tmp: Array(u64) = ---;
        defer deinit(*tmp);
        init(*tmp, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
        resize(*tmp, ROW_STRIDE * h);
        fill_memory(data(*tmp), 0, (cast(u64) size(*tmp)) * 8);

        if ROW_STRIDE == bit_image.row_stride {
            copy_memory(
                data(*tmp),
                data(*bit_image.data),
                (cast(u64) (bit_image.row_stride * internal_min(*bit_image.height, *h))) * 8
            );
        } else if bit_image.width > 0 && bit_image.height > 0 {
            HEIGHT: u32 = internal_min(*bit_image.height, *h);
            if 0 < HEIGHT {
                for i: 0..HEIGHT - 1 {
                    copy_memory(
                        (cast(**u64) *(index_explicit_31(*tmp, i * ROW_STRIDE))).*,
                        (cast(**u64) *(index_explicit_31(*bit_image.data, i * bit_image.row_stride))).*,
                        (cast(u64) internal_min(*ROW_STRIDE, *bit_image.row_stride)) * 8
                    );
                }
            }
        }
        move_to(*tmp, *bit_image.data);
    }
    bit_image.width = w;
    bit_image.height = h;
    bit_image.row_stride = ROW_STRIDE;
}

move_to :: (using array: *Array(u64), other: *Array(u64)) {
    move_to(*base, *other.base);
}

data :: (using array: *Array(u64)) -> *u64 {
    return cast(*u64) base.buffer;
}

size :: (using array: *Array(u64)) -> u32 {
    return base.size;
}

resize :: (using array: *Array(u64), new_size: u32) {
    resize(*base, new_size, true);
}

zero_out_memory :: (using array: *Array(u64)) {
    if base.buffer != null && base.size > 0 {
        fill_memory(base.buffer, 0, cast,no_check(u64) (base.element_size * base.size));
    }
}

assign_2 :: inline (using vector2i: *Vector2i, unnamed_12549: *Vector2i) -> *Vector2i {
    vector2i.* = ((cast(**Vector2i) *(unnamed_12549)).*).*;
    return (cast(**Vector2i) *(vector2i)).*;
}

size :: (using array: *Array(Vector2i)) -> u32 {
    return base.size;
}

find_chart_location :: (
    using atlas: *Pack_Atlas,
    options_: *Pack_Options,
    start_position: *Vector2i,
    atlas_bit_image: *Bit_Image,
    chart_bit_image: *Bit_Image,
    chart_bit_image_rotated: *Bit_Image,
    w: s32,
    h: s32,
    best_x: *s32,
    best_y: *s32,
    best_w: *s32,
    best_h: *s32,
    best_r: *s32,
    max_resolution: u32
) -> bool {
    ATTEMPTS: s32 = 4096;
    if options_.brute_force || ATTEMPTS >= w * h {
        return find_chart_location_brute_force(
            atlas,
            options_,
            start_position,
            atlas_bit_image,
            chart_bit_image,
            chart_bit_image_rotated,
            w,
            h,
            best_x,
            best_y,
            best_w,
            best_h,
            best_r,
            max_resolution
        );
    }
    return find_chart_location_random(
        atlas,
        options_,
        atlas_bit_image,
        chart_bit_image,
        chart_bit_image_rotated,
        w,
        h,
        best_x,
        best_y,
        best_w,
        best_h,
        best_r,
        ATTEMPTS,
        max_resolution
    );
}

find_chart_location_random :: (
    atlas: *Pack_Atlas,
    options_: *Pack_Options,
    atlas_bit_image: *Bit_Image,
    chart_bit_image: *Bit_Image,
    chart_bit_image_rotated: *Bit_Image,
    w: s32,
    h: s32,
    best_x: *s32,
    best_y: *s32,
    best_w: *s32,
    best_h: *s32,
    best_r: *s32,
    attempts: s32,
    max_resolution: u32
) -> bool {
    result: bool = false;
    BLOCK_SIZE: s32 = 4;
    best_metric: s32 = 2147483647;
    if 0 < attempts {
        for i: 0..attempts - 1 {
            cw := cast,no_check(s32) width(chart_bit_image);
            ch := cast,no_check(s32) height(chart_bit_image);
            r := cast,no_check(s32) ((ifx options_.rotate_charts then get_range(*atlas.rand, 1) else 0));
            if r == 1 {
                internal_swap(*cw, *ch);
            }

            x_range := w + 1;
            y_range := h + 1;

            if max_resolution > 0 {
                (ifx true { assignment_12: s32 = cast,no_check(s32) (internal_min(
                    *x_range,
                    (ifx true { temporary___g0: s32 = ((cast,no_check(s32) max_resolution) - cw); *temporary___g0; })
                )); (x_range) = assignment_12; assignment_12; });
                (ifx true { assignment_13: s32 = cast,no_check(s32) (internal_min(
                    *y_range,
                    (ifx true { temporary___g1: s32 = ((cast,no_check(s32) max_resolution) - ch); *temporary___g1; })
                )); (y_range) = assignment_13; assignment_13; });
            }
            x := cast,no_check(s32) get_range(*atlas.rand, cast,no_check(u32) x_range);
            y := cast,no_check(s32) get_range(*atlas.rand, cast,no_check(u32) y_range);
            if options_.block_align {
                x = internal_align(x, BLOCK_SIZE);
                y = internal_align(y, BLOCK_SIZE);
                if max_resolution > 0 && (x > (cast,no_check(s32) max_resolution) - cw || y > (cast,no_check(s32) max_resolution) - ch) {
                    continue;
                }
            }

            area_2 :=
                internal_max(*w, (ifx true { temporary___g2: s32 = (x + cw); *temporary___g2; })) *
                    internal_max(*h, (ifx true { temporary___g4: s32 = (y + ch); *temporary___g4; }));

            extents :=
                internal_max(
                    (ifx true { temporary___g6: s32 = internal_max(*w, (ifx true { temporary___g3: s32 = (x +
                    cw); *temporary___g3; })); *temporary___g6; }),
                    (ifx true { temporary___g8: s32 = internal_max(*h, (ifx true { temporary___g5: s32 = (y +
                    ch); *temporary___g5; })); *temporary___g8; })
                );
            metric := extents * extents + area_2;
            if metric > best_metric {
                continue;
            }
            if metric == best_metric && internal_min(*x, *y) > internal_min(best_x, best_y) {
                continue;
            }
            if can_blit(
                atlas_bit_image,
                *((ifx r == 1 then chart_bit_image_rotated.* else chart_bit_image.*)),
                cast,no_check(u32) x,
                cast,no_check(u32) y
            ) {
                result = true;
                best_metric = metric;
                best_x.* = x;
                best_y.* = y;
                best_w.* = cw;
                best_h.* = ch;
                best_r.* = ifx options_.rotate_charts then r else 0;
                if area_2 == w * h {
                    break;
                }
            }
        }
    }
    return result;
}

get_range :: (using kiss_rng: *KISS_Rng, range: u32) -> u32 {
    if range == 0 {
        return 0;
    }
    x = 69069 * x + 12345;
    y ^= y << 13;
    y ^= y >> 17;
    y ^= y << 5;
    t := ((698769069 * cast(u64) z) + cast(u64) c);
    c = cast,no_check(u32) (t >> 32);
    return (x + y + (ifx true { assignment_14: u32 = cast,no_check(u32) (cast,no_check(u32) t); (z) = assignment_14; assignment_14; })) % (range + 1);
}

can_blit :: (using bit_image: *Bit_Image, image: *Bit_Image, offset_x: u32, offset_y: u32) -> bool {
    {
        y: u32 = 0;
        while y < image.height {
            THIS_Y := y + offset_y;
            if THIS_Y >= height {
                y += 1;
                continue;
            }
            x: u32 = 0;
            while true {
                THIS_X := x + offset_x;
                if THIS_X >= width {
                    break;
                }
                THIS_BLOCK_SHIFT := THIS_X % 64;
                THIS_BLOCK: u64 =
                    ((cast(**u64) *(index_explicit_27(*data, THIS_X >> 6 +
                        THIS_Y * row_stride))).*).* >> THIS_BLOCK_SHIFT;
                BLOCK_SHIFT := x % 64;
                BLOCK: u64 =
                    ((cast(**u64) *(index_explicit_27(*image.data, x >> 6 +
                        y * image.row_stride))).*).* >> BLOCK_SHIFT;
                if THIS_BLOCK & BLOCK != 0 {
                    return false;
                }
                c_transpiler_compound_add(*(x), ((64 - internal_max(*THIS_BLOCK_SHIFT, *BLOCK_SHIFT))), u32, u32);
                if x >= image.width {
                    break;
                }
            }
            y += 1;
        }
    }
    return true;
}

internal_max :: (a: *u32, b: *u32) -> u32 {
    return max(a.*, b.*);
}

internal_min :: (a: *s32, b: *s32) -> s32 {
    return min(a.*, b.*);
}

internal_align :: (x: s32, a: s32) -> s32 {
    return (x + a - 1) & ~(a - 1);
}

internal_swap :: (a: *s32, b: *s32) {
    temp := a.*;
    assignment_15: s32 = b.*;
    (((cast(**s32) *(a)).*).*) = assignment_15;
    assignment_16: s32 = temp;
    (((cast(**s32) *(b)).*).*) = assignment_16;
}

find_chart_location_brute_force :: (
    atlas: *Pack_Atlas,
    options_: *Pack_Options,
    start_position: *Vector2i,
    atlas_bit_image: *Bit_Image,
    chart_bit_image: *Bit_Image,
    chart_bit_image_rotated: *Bit_Image,
    w: s32,
    h: s32,
    best_x: *s32,
    best_y: *s32,
    best_w: *s32,
    best_h: *s32,
    best_r: *s32,
    max_resolution: u32
) -> bool {
    STEP_SIZE := (ifx options_.block_align then cast(s32) 4 else 1);
    best_metric: s32 = 2147483647;

    for r: 0..cast(s32) 2 - 1 {
        cw := cast,no_check(s32) width(chart_bit_image);
        ch := cast,no_check(s32) height(chart_bit_image);
        if r == 1 {
            if options_.rotate_charts {
                internal_swap(*cw, *ch);
            } else {
                break;
            }
        }
        {
            y: s32 = start_position.y;
            while y <= h + STEP_SIZE {
                if max_resolution > 0 && y > (cast,no_check(s32) max_resolution) - ch {
                    break;
                }
                {
                    x: s32 = (ifx y == start_position.y then start_position.x else 0);
                    while x <= w + STEP_SIZE {
                        if max_resolution > 0 && x > (cast,no_check(s32) max_resolution) - cw {
                            break;
                        }

                        EXTENT_X := internal_max(*w, (ifx true { temporary___g0: s32 = (x + cw); *temporary___g0; }));
                        EXTENT_Y := internal_max(*h, (ifx true { temporary___g1: s32 = (y + ch); *temporary___g1; }));
                        AREA := EXTENT_X * EXTENT_Y;
                        EXTENTS := internal_max(*EXTENT_X, *EXTENT_Y);
                        METRIC := EXTENTS * EXTENTS + AREA;
                        if METRIC > best_metric {
                            x += STEP_SIZE;
                            continue;
                        }

                        if METRIC == best_metric && internal_max(*x, *y) >= internal_max(best_x, best_y) {
                            x += STEP_SIZE;
                            continue;
                        }
                        if !can_blit(
                            atlas_bit_image,
                            *((ifx r == 1 then chart_bit_image_rotated.* else chart_bit_image.*)),
                            cast,no_check(u32) x,
                            cast,no_check(u32) y
                        ) {
                            x += STEP_SIZE;
                            continue;
                        }
                        best_metric = METRIC;
                        best_x.* = x;
                        best_y.* = y;
                        best_w.* = cw;
                        best_h.* = ch;
                        best_r.* = r;
                        if AREA == w * h {
                            return true;
                        }
                        x += STEP_SIZE;
                    }
                }
                y += STEP_SIZE;
            }
        }
    }
    return best_metric != 2147483647;
}

push_back :: (using array: *Array(Vector2i), value: *Vector2i) {
    push_back(*base, cast(*u8) ((cast(**Vector2i) *(value)).*));
}

push_back :: (using array: *Array(*Atlas_Image), value: **Atlas_Image) {
    push_back(*base, cast(*u8) (cast(**Atlas_Image) value));
}

push_back :: (using array: *Array(*Bit_Image), value: **Bit_Image) {
    push_back(*base, cast(*u8) (cast(**Bit_Image) value));
}

dilate :: (using bit_image: *Bit_Image, padding: u32) {
    tmp: Bit_Image = ---;
    defer deinit(*tmp);
    init(*tmp, width, height);
    if 0 < padding {
        for p: 0..padding - 1 {
            zero_out_memory(*tmp);
            {
                y: u32 = 0;
                while y < height {
                    {
                        x: u32 = 0;
                        while x < width {
                            b := get(bit_image, x, y);
                            if !b {
                                if x > 0 {
                                    c_transpiler_compound_or(*(b), (cast(s32) get(bit_image, x - 1, y)), s32, s32);
                                    if y > 0 {
                                        c_transpiler_compound_or(*(b), (cast(s32) get(bit_image, x - 1, y - 1)), s32, s32);
                                    }
                                    if y < height - 1 {
                                        c_transpiler_compound_or(*(b), (cast(s32) get(bit_image, x - 1, y + 1)), s32, s32);
                                    }
                                }
                                if y > 0 {
                                    c_transpiler_compound_or(*(b), (cast(s32) get(bit_image, x, y - 1)), s32, s32);
                                }
                                if y < height - 1 {
                                    c_transpiler_compound_or(*(b), (cast(s32) get(bit_image, x, y + 1)), s32, s32);
                                }
                                if x < width - 1 {
                                    c_transpiler_compound_or(*(b), (cast(s32) get(bit_image, x + 1, y)), s32, s32);
                                    if y > 0 {
                                        c_transpiler_compound_or(*(b), (cast(s32) get(bit_image, x + 1, y - 1)), s32, s32);
                                    }
                                    if y < height - 1 {
                                        c_transpiler_compound_or(*(b), (cast(s32) get(bit_image, x + 1, y + 1)), s32, s32);
                                    }
                                }
                            }
                            if b {
                                set(*tmp, x, y);
                            }
                            x += 1;
                        }
                    }
                    y += 1;
                }
            }
            copy_to(*tmp.data, *data);
        }
    }
}

copy_to :: (using array: *Array(u64), other: *Array(u64)) {
    copy_to(*base, *other.base);
}

copy_to :: (using array_base: *Array_Base, other: *Array_Base) {
    assert(element_size == other.element_size);
    assert(size > 0);
    resize(other, size, true);
    if other.buffer != null && buffer != null && size > 0 {
        copy_memory(other.buffer, buffer, cast,no_check(u64) (size * element_size));
    }
}

zero_out_memory :: (using bit_image: *Bit_Image) {
    zero_out_memory(*data);
}

copy_to :: (using bit_image: *Bit_Image, other: *Bit_Image) {
    other.width = width;
    other.height = height;
    other.row_stride = row_stride;
    copy_to(*data, *other.data);
}

bilinear_expand :: (
    atlas: *Pack_Atlas,
    chart: *Pack_Chart,
    source: *Bit_Image,
    dest: *Bit_Image,
    dest_rotated: *Bit_Image,
    boundary_edge_grid: *Uniform_Grid2
) {
    EDGE_COUNT: u32 = ---;
    i_2: u32 = ---;
    i: u32 = ---;
    X_OFFSETS: [8] s32 = ---;
    Y_OFFSETS: [8] s32 = ---;
    y: u32 = ---;
    x: u32 = ---;
    s: u32 = ---;
    SX: s32 = ---;
    SY: s32 = ---;
    CENTROID: Vector2 = ---;
    SQUARE_VERTICES: [4] Vector2 = ---;
    j: u32 = ---;
    code_block_to_execute: s64 = 43;
    // The transpiler had to use this control-flow loop because the source code used a goto, which Jai does not support.
    while c_transpiler_dispatch := true {
        if code_block_to_execute < 0 break;
        if code_block_to_execute == {
            case 0; {
                code_block_to_execute = 7;
                continue c_transpiler_dispatch;
            }
            case 1; {
                if y < height(source) code_block_to_execute = 29;
                else code_block_to_execute = -1;
                continue c_transpiler_dispatch;
            }
            case 2; {
                y += 1;
                code_block_to_execute = 1;
                continue c_transpiler_dispatch;
            }
            case 3; {
                if x < width(source) code_block_to_execute = 28;
                else code_block_to_execute = 2;
                continue c_transpiler_dispatch;
            }
            case 4; {
                x += 1;
                code_block_to_execute = 3;
                continue c_transpiler_dispatch;
            }
            case 5; {
                set(dest_rotated, y, x);
                code_block_to_execute = 4;
                continue c_transpiler_dispatch;
            }
            case 7; {
                set(dest, x, y);
                if dest_rotated != null code_block_to_execute = 5;
                else code_block_to_execute = 4;
                continue c_transpiler_dispatch;
            }
            case 8; {
                code_block_to_execute = 4;
                continue c_transpiler_dispatch;
            }
            case 9; {
                if j < 4 code_block_to_execute = 12;
                else code_block_to_execute = 8;
                continue c_transpiler_dispatch;
            }
            case 10; {
                j += 1;
                code_block_to_execute = 9;
                continue c_transpiler_dispatch;
            }
            case 11; {
                code_block_to_execute = 0;
                continue c_transpiler_dispatch;
            }
            case 12; {
                if intersect(boundary_edge_grid, SQUARE_VERTICES[j], SQUARE_VERTICES[(j + 1) % 4], 0.0) code_block_to_execute = 11;
                else code_block_to_execute = 10;
                continue c_transpiler_dispatch;
            }
            case 15; {
                CENTROID = make_vector2((cast,no_check(float32) x) + 0.5, (cast,no_check(float32) y) + 0.5);
                SQUARE_VERTICES = Vector2.[
                    make_vector2(CENTROID.x - 1.0, CENTROID.y - 1.0),
                    make_vector2(CENTROID.x + 1.0, CENTROID.y - 1.0),
                    make_vector2(CENTROID.x + 1.0, CENTROID.y + 1.0),
                    make_vector2(CENTROID.x - 1.0, CENTROID.y + 1.0)
                ];
                j = 0;
                code_block_to_execute = 9;
                continue c_transpiler_dispatch;
            }
            case 16; {
                code_block_to_execute = 4;
                continue c_transpiler_dispatch;
            }
            case 17; {
                if s == 8 code_block_to_execute = 16;
                else code_block_to_execute = 15;
                continue c_transpiler_dispatch;
            }
            case 18; {
                if s < 8 code_block_to_execute = 25;
                else code_block_to_execute = 17;
                continue c_transpiler_dispatch;
            }
            case 19; {
                s += 1;
                code_block_to_execute = 18;
                continue c_transpiler_dispatch;
            }
            case 20; {
                code_block_to_execute = 17;
                continue c_transpiler_dispatch;
            }
            case 21; {
                if get(source, cast,no_check(u32) SX, cast,no_check(u32) SY) code_block_to_execute = 20;
                else code_block_to_execute = 19;
                continue c_transpiler_dispatch;
            }
            case 22; {
                code_block_to_execute = 19;
                continue c_transpiler_dispatch;
            }
            case 25; {
                SX = (cast,no_check(s32) x) + X_OFFSETS[s];
                SY = (cast,no_check(s32) y) + Y_OFFSETS[s];
                if SX < 0 || SY < 0 || SX >= cast,no_check(s32) width(source) || SY >= cast,no_check(s32) height(source) code_block_to_execute = 22;
                else code_block_to_execute = 21;
                continue c_transpiler_dispatch;
            }
            case 26; {
                s = 0;
                code_block_to_execute = 18;
                continue c_transpiler_dispatch;
            }
            case 27; {
                code_block_to_execute = 0;
                continue c_transpiler_dispatch;
            }
            case 28; {
                if get(source, x, y) code_block_to_execute = 27;
                else code_block_to_execute = 26;
                continue c_transpiler_dispatch;
            }
            case 29; {
                x = 0;
                code_block_to_execute = 3;
                continue c_transpiler_dispatch;
            }
            case 32; {
                X_OFFSETS = s32.[
                    -1,
                    0,
                    1,
                    -1,
                    1,
                    -1,
                    0,
                    1
                ];
                Y_OFFSETS = s32.[
                    -1,
                    -1,
                    -1,
                    0,
                    0,
                    1,
                    1,
                    1
                ];
                y = 0;
                code_block_to_execute = 1;
                continue c_transpiler_dispatch;
            }
            case 33; {
                if i < chart.indices.length code_block_to_execute = 35;
                else code_block_to_execute = 32;
                continue c_transpiler_dispatch;
            }
            case 35; {
                append(boundary_edge_grid, i);
                i += 1;
                code_block_to_execute = 33;
                continue c_transpiler_dispatch;
            }
            case 36; {
                i = 0;
                code_block_to_execute = 33;
                continue c_transpiler_dispatch;
            }
            case 37; {
                if i_2 < EDGE_COUNT code_block_to_execute = 39;
                else code_block_to_execute = 32;
                continue c_transpiler_dispatch;
            }
            case 39; {
                append(boundary_edge_grid, ((cast(**u32) *(index_explicit_7(chart.boundary_edges, i_2))).*).*);
                i_2 += 1;
                code_block_to_execute = 37;
                continue c_transpiler_dispatch;
            }
            case 41; {
                EDGE_COUNT = size(chart.boundary_edges);
                i_2 = 0;
                code_block_to_execute = 37;
                continue c_transpiler_dispatch;
            }
            case 43; {
                reset(
                    boundary_edge_grid,
                    make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2(chart.vertices),
                    chart.indices,
                    0
                );
                if chart.boundary_edges != null code_block_to_execute = 41;
                else code_block_to_execute = 36;
                continue c_transpiler_dispatch;
            }
        }
        assert(false, tprint("invalid code block to execute %", code_block_to_execute));
        break;
    }
}

intersect :: (using uniform_grid2: *Uniform_Grid2, v1: Vector2, v2: Vector2, epsilon_2: float32) -> bool {
    local_v1: Vector2 = v1;
    local_v2: Vector2 = v2;
    EDGE_COUNT := size(*edges);
    brute_force := EDGE_COUNT <= 20;
    if !brute_force && is_empty(*cell_data_offsets) {
        brute_force = cast,no_check(bool) (!create_grid(uniform_grid2));
    }
    if brute_force {
        if 0 < EDGE_COUNT {
            for j_2: 0..EDGE_COUNT - 1 {
                EDGE_2: u32 = ((cast(**u32) *(index_explicit(*edges, j_2))).*).*;
                if internal_lines_intersect(
                    *local_v1,
                    *local_v2,
                    (ifx true { temporary___g0: Vector2 = edge_position0(uniform_grid2, EDGE_2); *temporary___g0; }),
                    (ifx true { temporary___g1: Vector2 = edge_position1(uniform_grid2, EDGE_2); *temporary___g1; }),
                    epsilon_2
                ) {
                    return true;
                }
            }
        }
    } else {
        compute_potential_edges(uniform_grid2, local_v1, local_v2);
        prev_edge: u32 = 4294967295;
        {
            j: u32 = 0;
            while j < size(*potential_edges) {
                EDGE: u32 = ((cast(**u32) *(index_explicit(*potential_edges, j))).*).*;
                if EDGE == prev_edge {
                    j += 1;
                    continue;
                }
                if internal_lines_intersect(
                    *local_v1,
                    *local_v2,
                    (ifx true { temporary___g2: Vector2 = edge_position0(uniform_grid2, EDGE); *temporary___g2; }),
                    (ifx true { temporary___g4: Vector2 = edge_position1(uniform_grid2, EDGE); *temporary___g4; }),
                    epsilon_2
                ) {
                    return true;
                }
                prev_edge = EDGE;
                j += 1;
            }
        }
    }
    return false;
}

edge_position1 :: (using uniform_grid2: *Uniform_Grid2, edge_2: u32) -> Vector2 {
    return ((cast(**Vector2) *(index_explicit_13(*positions, vertex_at(uniform_grid2, internal_mesh_edge_index1(edge_2))))).*).*;
}

edge_position0 :: (using uniform_grid2: *Uniform_Grid2, edge_2: u32) -> Vector2 {
    return ((cast(**Vector2) *(index_explicit_13(*positions, vertex_at(uniform_grid2, internal_mesh_edge_index0(edge_2))))).*).*;
}

internal_lines_intersect :: (a1: *Vector2, a2: *Vector2, b1: *Vector2, b2: *Vector2, epsilon_2: float32) -> bool {
    V0 := internal_operator(a2, a1);
    V1 := internal_operator(b2, b1);
    DENOM := -V1.x * V0.y + V0.x * V1.y;
    if internal_equal(DENOM, 0.0, epsilon_2) {
        return false;
    }
    S := (-V0.y * (a1.x - b1.x) + V0.x * (a1.y - b1.y)) / DENOM;
    if S > epsilon_2 && S < 1.0 - epsilon_2 {
        T := (V1.x * (a1.y - b1.y) - V1.y * (a1.x - b1.x)) / DENOM;
        return T > epsilon_2 && T < 1.0 - epsilon_2;
    }
    return false;
}

compute_potential_edges :: (using uniform_grid2: *Uniform_Grid2, p1: Vector2, p2: Vector2) {
    clear(*potential_edges);
    traverse(uniform_grid2, p1, p2);
    {
        j: u32 = 0;
        while j < size(*traversed_cell_offsets) {
            CELL: u32 = ((cast(**u32) *(index_explicit(*traversed_cell_offsets, j))).*).*;
            offset: u32 = ((cast(**u32) *(index_explicit(*cell_data_offsets, CELL))).*).*;
            while offset != 4294967295 {
                EDGE2: u32 = ((cast(**u32) *(index_explicit(*cell_data, offset))).*).*;
                push_back(*potential_edges, *EDGE2);
                offset = ((cast(**u32) *(index_explicit(*cell_data, offset + 1))).*).*;
            }
            j += 1;
        }
    }
    if is_empty(*potential_edges) {
        return;
    }
    internal_insertion_sort(data(*potential_edges), size(*potential_edges));
}

internal_insertion_sort :: (data_40: *u32, length: u32) {
    if 1 < cast,no_check(s32) length {
        for i: 1..cast,no_check(s32) length - 1 {
            x := data_40[i];
            j: s32 = i - 1;
            while j >= 0 && x < data_40[j] {
                data_40[j + 1] = data_40[j];
                j -= 1;
            }
            data_40[j + 1] = x;
        }
    }
}

push_back :: (using array: *Array(u32), value: *u32) {
    push_back(*base, cast(*u8) ((cast(**u32) *(value)).*));
}

traverse :: (using uniform_grid2: *Uniform_Grid2, p1: Vector2, p2: Vector2) {
    local_p1: Vector2 = p1;
    local_p2: Vector2 = p2;
    DIR := internal_operator(*local_p2, *local_p1);
    NORMAL :=
        internal_normalize_safe(
            *DIR,
            (ifx true { temporary___g0: Vector2 = make_vector2(0.0); *temporary___g0; })
        );
    STEP_X := (ifx DIR.x >= 0 then cast(s32) 1 else -1);
    STEP_Y := (ifx DIR.y >= 0 then cast(s32) 1 else -1);
    FIRST_CELL := u32.[ cell_x(uniform_grid2, local_p1.x), cell_y(uniform_grid2, local_p1.y) ];
    LAST_CELL := u32.[ cell_x(uniform_grid2, local_p2.x), cell_y(uniform_grid2, local_p2.y) ];

    dist_to_next_cell_x: float32 = ifx STEP_X == 1
        then (FIRST_CELL[0] + 1) * cell_size - (local_p1.x - grid_origin.x)
        else local_p1.x - grid_origin.x - FIRST_CELL[0] * cell_size;

    dist_to_next_cell_y: float32 = ifx STEP_Y == 1
        then (FIRST_CELL[1] + 1) * cell_size - (local_p1.y - grid_origin.y)
        else local_p1.y - grid_origin.y - FIRST_CELL[1] * cell_size;
    t_max_x, t_max_y, t_delta_x, t_delta_y: float32 = ---;
    if NORMAL.x > K_EPSILON || NORMAL.x < -K_EPSILON {
        t_max_x = dist_to_next_cell_x * STEP_X / NORMAL.x;
        t_delta_x = cell_size * STEP_X / NORMAL.x;
    } else {
        t_delta_x = cast(float32) 3.40282347e+38;
        t_max_x = t_delta_x;
    }
    if NORMAL.y > K_EPSILON || NORMAL.y < -K_EPSILON {
        t_max_y = dist_to_next_cell_y * STEP_Y / NORMAL.y;
        t_delta_y = cell_size * STEP_Y / NORMAL.y;
    } else {
        t_delta_y = cast(float32) 3.40282347e+38;
        t_max_y = t_delta_y;
    }
    clear(*traversed_cell_offsets);
    push_back(
        *traversed_cell_offsets,
        (ifx true { temporary___g1: u32 = (FIRST_CELL[0] + FIRST_CELL[1] * grid_width); *temporary___g1; })
    );
    current_cell := u32.[ FIRST_CELL[0], FIRST_CELL[1] ];
    while !(current_cell[0] == LAST_CELL[0] && current_cell[1] == LAST_CELL[1]) {
        if t_max_x < t_max_y {
            t_max_x += t_delta_x;
            current_cell[0] += cast,no_check(u32) STEP_X;
        } else {
            t_max_y += t_delta_y;
            current_cell[1] += cast,no_check(u32) STEP_Y;
        }
        if current_cell[0] >= grid_width || current_cell[1] >= grid_height {
            break;
        }
        if STEP_X == -1 && current_cell[0] < LAST_CELL[0] {
            break;
        }
        if STEP_X == 1 && current_cell[0] > LAST_CELL[0] {
            break;
        }
        if STEP_Y == -1 && current_cell[1] < LAST_CELL[1] {
            break;
        }
        if STEP_Y == 1 && current_cell[1] > LAST_CELL[1] {
            break;
        }
        push_back(
            *traversed_cell_offsets,
            (ifx true { temporary___g2: u32 = (current_cell[0] + current_cell[1] * grid_width); *temporary___g2; })
        );
    }
}

cell_y :: (using uniform_grid2: *Uniform_Grid2, y: float32) -> u32 {
    return internal_min(
        (ifx true { temporary___g2: u32 = cast,no_check(u32) internal_max(
        (ifx true { temporary___g0: float32 = 0.0; *temporary___g0; }),
        (ifx true { temporary___g1: float32 = ((y - grid_origin.y) / cell_size); *temporary___g1; })
    ); *temporary___g2; }),
        (ifx true { temporary___g4: u32 = (grid_height - 1); *temporary___g4; })
    );
}

cell_x :: (using uniform_grid2: *Uniform_Grid2, x: float32) -> u32 {
    return internal_min(
        (ifx true { temporary___g2: u32 = cast,no_check(u32) internal_max(
        (ifx true { temporary___g0: float32 = 0.0; *temporary___g0; }),
        (ifx true { temporary___g1: float32 = ((x - grid_origin.x) / cell_size); *temporary___g1; })
    ); *temporary___g2; }),
        (ifx true { temporary___g4: u32 = (grid_width - 1); *temporary___g4; })
    );
}

clear :: (using array: *Array(u32)) {
    clear(*base);
}

clear :: (using array_base: *Array_Base) {
    size = 0;
}

create_grid :: (using uniform_grid2: *Uniform_Grid2) -> bool {
    EDGE_COUNT := size(*edges);
    edge_extents: Extents2 = ---;
    init(*edge_extents);
    reset(*edge_extents);
    if 0 < EDGE_COUNT {
        for i_3: 0..EDGE_COUNT - 1 {
            EDGE_2: u32 = ((cast(**u32) *(index_explicit(*edges, i_3))).*).*;
            add_in_place(*edge_extents, edge_position0(uniform_grid2, EDGE_2));
            add_in_place(*edge_extents, edge_position1(uniform_grid2, EDGE_2));
        }
    }
    assign_3(*grid_origin, *edge_extents.min);

    EXTENTS_SIZE := internal_operator(*edge_extents.max, *edge_extents.min);
    (ifx true { assignment_17: float32 = cast,no_check(float32) ((internal_max(*EXTENTS_SIZE.x, *EXTENTS_SIZE.y) / cast,no_check(float32) internal_clamp(
        *EDGE_COUNT,
        (ifx true { temporary___g0: u32 = cast(u32) 32; *temporary___g0; }),
        (ifx true { temporary___g1: u32 = cast(u32) 512; *temporary___g1; })
    ))); (cell_size) = assignment_17; assignment_17; });
    if cell_size <= 0.0 {
        return false;
    }
    grid_width = cast,no_check(u32) ceilf(EXTENTS_SIZE.x / cell_size);
    grid_height = cast,no_check(u32) ceilf(EXTENTS_SIZE.y / cell_size);
    if grid_width <= 1 || grid_height <= 1 {
        return false;
    }

    resize(*cell_data_offsets, grid_width * grid_height);
    {
        i_2: u32 = 0;
        while i_2 < size(*cell_data_offsets) {
            ((cast(**u32) *(index_explicit(*cell_data_offsets, i_2))).*).* = 4294967295;
            i_2 += 1;
        }
    }
    clear(*cell_data);
    reserve(*cell_data, EDGE_COUNT * 2);
    if 0 < EDGE_COUNT {
        for i: 0..EDGE_COUNT - 1 {
            EDGE: u32 = ((cast(**u32) *(index_explicit(*edges, i))).*).*;
            traverse(uniform_grid2, edge_position0(uniform_grid2, EDGE), edge_position1(uniform_grid2, EDGE));
            assert(!is_empty(*traversed_cell_offsets));
            {
                j: u32 = 0;
                while j < size(*traversed_cell_offsets) {
                    CELL: u32 = ((cast(**u32) *(index_explicit(*traversed_cell_offsets, j))).*).*;
                    offset: u32 = ((cast(**u32) *(index_explicit(*cell_data_offsets, CELL))).*).*;
                    if offset == 4294967295 {
                        assignment_18: u32 = size(*cell_data);
                        (((cast(**u32) *(index_explicit(*cell_data_offsets, CELL))).*).*) = assignment_18;
                    } else {
                        while true {
                            next_offset: *u32 = cast,no_check(*u32) index_explicit(*cell_data, offset + 1);
                            if next_offset.* == 4294967295 {
                                assignment_19: u32 = size(*cell_data);
                                (((cast(**u32) *(next_offset)).*).*) = assignment_19;
                                break;
                            }
                            offset = next_offset.*;
                        }
                    }
                    push_back(*cell_data, *EDGE);
                    push_back(*cell_data, (ifx true { temporary___g2: u32 = cast(u32) 4294967295; *temporary___g2; }));
                    j += 1;
                }
            }
        }
    }
    return true;
}

reserve :: (using array: *Array(u32), desired_size: u32) {
    reserve(*base, desired_size);
}

internal_clamp :: (x: *u32, a: *u32, b: *u32) -> u32 {
    return internal_min((ifx true { temporary___g0: u32 = internal_max(x, a); *temporary___g0; }), b);
}

assign_3 :: inline (using vector2: *Vector2, unnamed_16363: *Vector2) -> *Vector2 {
    vector2.* = ((cast(**Vector2) *(unnamed_16363)).*).*;
    return (cast(**Vector2) *(vector2)).*;
}

add_in_place :: (using extents2: *Extents2, p: Vector2) {
    local_p: Vector2 = p;
    assign(*min, (ifx true { temporary___g0: Vector2 = internal_min(*min, *local_p); *temporary___g0; }));
    assign(*max, (ifx true { temporary___g1: Vector2 = internal_max(*max, *local_p); *temporary___g1; }));
}

reset :: (using extents2: *Extents2) {
    min.y = cast(float32) 3.40282347e+38;
    min.x = min.y;
    max.y = -cast(float32) 3.40282347e+38;
    max.x = max.y;
}

append :: (using uniform_grid2: *Uniform_Grid2, edge_2: u32) {
    assert(is_empty(*cell_data_offsets));
    push_back(*edges, *edge_2);
}

reset :: (
    using uniform_grid2: *Uniform_Grid2,
    _positions: Const_Array_View(Vector2),
    _indices: Const_Array_View(u32),
    reserve_edge_count: u32
) {
    local__positions: Const_Array_View(Vector2) = _positions;
    local__indices: Const_Array_View(u32) = _indices;
    clear(*edges);
    if reserve_edge_count > 0 {
        reserve(*edges, reserve_edge_count);
    }
    positions = local__positions;
    indices = local__indices;
    clear(*cell_data_offsets);
}

draw_triangle_callback :: (param: *void, x: s32, y: s32) -> bool {
    args := cast(*Atlas_Draw_Triangle_Callback_Args) param;
    set(args.chart_bit_image, cast,no_check(u32) x, cast,no_check(u32) y);
    if args.chart_bit_image_rotated != null {
        set(args.chart_bit_image_rotated, cast,no_check(u32) y, cast,no_check(u32) x);
    }
    return true;
}

internal_raster_draw_triangle :: (extents: *Vector2, v: *Vector2, cb: Sampling_Callback, param: *void) -> bool {
    tri: Triangle = ---;
    init(*tri, *v[0], *v[1], *v[2]);

    if is_valid(*tri) {
        return draw_aa(*tri, extents, cast,no_check(Sampling_Callback) (cb), param);
    }
    return true;
}

draw_aa :: (using triangle: *Triangle, extents: *Vector2, cb: Sampling_Callback, param: *void) -> bool {
    PX_INSIDE := 1.0 / sqrtf(2.0);
    PX_OUTSIDE := -1.0 / sqrtf(2.0);
    BK_SIZE: float32 = 8;
    BK_INSIDE := sqrtf(BK_SIZE * BK_SIZE / 2.0);
    BK_OUTSIDE := -sqrtf(BK_SIZE * BK_SIZE / 2.0);

    minx :=
        floorf(
            internal_max(
            (ifx true { temporary___g0: float32 = internal_min3(*v1.x, *v2.x, *v3.x); *temporary___g0; }),
            (ifx true { temporary___g1: float32 = 0.0; *temporary___g1; })
        )
        );
    miny :=
        floorf(
            internal_max(
            (ifx true { temporary___g2: float32 = internal_min3(*v1.y, *v2.y, *v3.y); *temporary___g2; }),
            (ifx true { temporary___g4: float32 = 0.0; *temporary___g4; })
        )
        );
    maxx :=
        ceilf(
            internal_min(
            (ifx true { temporary___g3: float32 = internal_max3(*v1.x, *v2.x, *v3.x); *temporary___g3; }),
            (ifx true { temporary___g6: float32 = (extents.x - 1.0); *temporary___g6; })
        )
        );
    maxy :=
        ceilf(
            internal_min(
            (ifx true { temporary___g5: float32 = internal_max3(*v1.y, *v2.y, *v3.y); *temporary___g5; }),
            (ifx true { temporary___g8: float32 = (extents.y - 1.0); *temporary___g8; })
        )
        );

    minx = floorf(minx);
    miny = floorf(miny);

    minx += cast,no_check(float32) (cast(float64) 0.5);
    miny += cast,no_check(float32) (cast(float64) 0.5);
    maxx += cast,no_check(float32) (cast(float64) 0.5);
    maxy += cast,no_check(float32) (cast(float64) 0.5);

    c1 := n1.x * -v1.x + n1.y * -v1.y;
    c2 := n2.x * -v2.x + n2.y * -v2.y;
    c3 := n3.x * -v3.x + n3.y * -v3.y;

    {
        y0 := miny;
        while y0 <= maxy {
            {
                x0 := minx;
                while x0 <= maxx {
                    xc := x0 + (BK_SIZE - cast(s32) 1) / 2.0;
                    yc := y0 + (BK_SIZE - cast(s32) 1) / 2.0;

                    a_c := c1 + n1.x * xc + n1.y * yc;
                    b_c := c2 + n2.x * xc + n2.y * yc;
                    c_c := c3 + n3.x * xc + n3.y * yc;

                    if a_c <= BK_OUTSIDE || b_c <= BK_OUTSIDE || c_c <= BK_OUTSIDE {
                        x0 += BK_SIZE;
                        continue;
                    }

                    if a_c >= BK_INSIDE && b_c >= BK_INSIDE && c_c >= BK_INSIDE {
                        {
                            y_2 := y0;
                            while y_2 < y0 + BK_SIZE {
                                {
                                    x_2 := x0;
                                    while x_2 < x0 + BK_SIZE {
                                        if !cb(param, cast,no_check(s32) x_2, cast,no_check(s32) y_2) {
                                            return false;
                                        }
                                        x_2 += 1;
                                    }
                                }
                                y_2 += 1;
                            }
                        }
                    } else {
                        cy1 := c1 + n1.x * x0 + n1.y * y0;
                        cy2 := c2 + n2.x * x0 + n2.y * y0;
                        cy3 := c3 + n3.x * x0 + n3.y * y0;
                        {
                            y := y0;
                            while y < y0 + BK_SIZE {
                                cx1 := cy1;
                                cx2 := cy2;
                                cx3 := cy3;
                                {
                                    x := x0;
                                    while x < x0 + BK_SIZE {
                                        if cx1 >= PX_INSIDE && cx2 >= PX_INSIDE && cx3 >= PX_INSIDE {
                                            if !cb(param, cast,no_check(s32) x, cast,no_check(s32) y) {
                                                return false;
                                            }
                                        } else if cx1 >= PX_OUTSIDE && cx2 >= PX_OUTSIDE && cx3 >= PX_OUTSIDE {
                                            ct: Clipped_Triangle = ---;
                                            init(
                                                *ct,
                                                (ifx true { temporary___g9: Vector2 = internal_operator(
                                                *v1,
                                                (ifx true { temporary___g7: Vector2 = make_vector2(x, y); *temporary___g7; })
                                            ); *temporary___g9; }),
                                                (ifx true { temporary___g11: Vector2 = internal_operator(
                                                *v2,
                                                (ifx true { temporary___g10: Vector2 = make_vector2(x, y); *temporary___g10; })
                                            ); *temporary___g11; }),
                                                (ifx true { temporary___g13: Vector2 = internal_operator(
                                                *v3,
                                                (ifx true { temporary___g12: Vector2 = make_vector2(x, y); *temporary___g12; })
                                            ); *temporary___g13; })
                                            );
                                            clip_aa_box(
                                                *ct,
                                                cast,no_check(float32) (-cast(float64) 0.5),
                                                cast,no_check(float32) (-cast(float64) 0.5),
                                                cast,no_check(float32) (cast(float64) 0.5),
                                                cast,no_check(float32) (cast(float64) 0.5)
                                            );
                                            if area(*ct) > 0.0 {
                                                if !cb(param, cast,no_check(s32) x, cast,no_check(s32) y) {
                                                    return false;
                                                }
                                            }
                                        }
                                        cx1 += n1.x;
                                        cx2 += n2.x;
                                        cx3 += n3.x;
                                        x += 1;
                                    }
                                }
                                cy1 += n1.y;
                                cy2 += n2.y;
                                cy3 += n3.y;
                                y += 1;
                            }
                        }
                    }
                    x0 += BK_SIZE;
                }
            }
            y0 += BK_SIZE;
        }
    }
    return true;
}

area :: (using clipped_triangle: *Clipped_Triangle) -> float32 {
    return area;
}

clip_aa_box :: (using clipped_triangle: *Clipped_Triangle, x0: float32, y0: float32, x1: float32, y1: float32) {
    clip_vertical_plane(clipped_triangle, x0, cast,no_check(float32) (-cast(s32) 1));
    clip_horizontal_plane(clipped_triangle, y0, cast,no_check(float32) (-cast(s32) 1));
    clip_vertical_plane(clipped_triangle, x1, 1);
    clip_horizontal_plane(clipped_triangle, y1, 1);
    compute_area(clipped_triangle);
}

compute_area :: (using clipped_triangle: *Clipped_Triangle) {
    v := vertex_buffers[active_vertex_buffer];
    assign_3(*v[num_vertices], *v[0]);
    area = 0;
    {
        k: u32 = 0;
        while k < num_vertices {
            f := v[k].x * v[k + 1].y - v[k + 1].x * v[k].y;
            area += f;
            k += 1;
        }
    }
    area = 0.5 * fabsf(area);
}

clip_horizontal_plane :: (using clipped_triangle: *Clipped_Triangle, offset: float32, clipdirection: float32) {
    v := vertex_buffers[active_vertex_buffer];
    active_vertex_buffer ^= 1;
    v2 := vertex_buffers[active_vertex_buffer];
    assign_3(*v[num_vertices], *v[0]);
    dy2: float32 = ---;
    dy1 := offset - v[0].y;
    dy2in: s32 = ---;
    dy1in := cast(s32) (clipdirection * dy1 >= 0);
    p: u32 = 0;
    {
        k: u32 = 0;
        while k < num_vertices {
            dy2 = offset - v[k + 1].y;
            dy2in = cast(s32) (clipdirection * dy2 >= 0);
            if dy1in != 0 {
                assign_3(*v2[c_transpiler_post_increment(*(p))], *v[k]);
            }
            if dy1in + dy2in == 1 {
                dx := v[k + 1].x - v[k].x;
                dy := v[k + 1].y - v[k].y;
                assign(
                    *v2[c_transpiler_post_increment(*(p))],
                    (ifx true { temporary___g0: Vector2 = make_vector2(v[k].x +
                    dy1 * (dx / dy), offset); *temporary___g0; })
                );
            }
            dy1 = dy2;
            dy1in = dy2in;
            k += 1;
        }
    }
    num_vertices = p;
}

clip_vertical_plane :: (using clipped_triangle: *Clipped_Triangle, offset: float32, clipdirection: float32) {
    v := vertex_buffers[active_vertex_buffer];
    active_vertex_buffer ^= 1;
    v2 := vertex_buffers[active_vertex_buffer];
    assign_3(*v[num_vertices], *v[0]);
    dx2: float32 = ---;
    dx1 := offset - v[0].x;
    dx2in: s32 = ---;
    dx1in := cast(s32) (clipdirection * dx1 >= 0);
    p: u32 = 0;
    {
        k: u32 = 0;
        while k < num_vertices {
            dx2 = offset - v[k + 1].x;
            dx2in = cast(s32) (clipdirection * dx2 >= 0);
            if dx1in != 0 {
                assign_3(*v2[c_transpiler_post_increment(*(p))], *v[k]);
            }
            if dx1in + dx2in == 1 {
                dx := v[k + 1].x - v[k].x;
                dy := v[k + 1].y - v[k].y;
                assign(
                    *v2[c_transpiler_post_increment(*(p))],
                    (ifx true { temporary___g0: Vector2 = make_vector2(offset, v[k].y +
                    dx1 * (dy / dx)); *temporary___g0; })
                );
            }
            dx1 = dx2;
            dx1in = dx2in;
            k += 1;
        }
    }
    num_vertices = p;
}

is_valid :: (using triangle: *Triangle) -> bool {
    E0 := internal_operator(*v3, *v1);
    E1 := internal_operator(*v2, *v1);
    AREA := E0.y * E1.x - E1.y * E0.x;
    return AREA != 0.0;
}

internal_ftoi_ceil :: (val: float32) -> s32 {
    return cast,no_check(s32) ceilf(val);
}

sort :: (using radix_sort_2: *Radix_Sort, input: Const_Array_View(float32)) {
    local_input: Const_Array_View(float32) = input;
    if local_input.length == 0 {
        clear(*buffer1);
        clear(*buffer2);
        ranks = cast,no_check(*u32) data(*buffer1);
        ranks2 = cast,no_check(*u32) data(*buffer2);
        return;
    }

    resize(*buffer1, local_input.length);
    resize(*buffer2, local_input.length);
    ranks = cast,no_check(*u32) data(*buffer1);
    ranks2 = cast,no_check(*u32) data(*buffer2);
    valid_ranks = false;
    if local_input.length < 32 {
        insertion_sort(radix_sort_2, local_input);
    } else {
        {
            i_2: u32 = 0;
            while i_2 < local_input.length {
                float_flip(radix_sort_2, cast(*u32) ((cast(**float32) *(index_explicit_32(*local_input, i_2))).*));
                i_2 += 1;
            }
        }
        radix_sort(
            radix_sort_2,
            make_struct_xatlas_internal_const_array_view_unsigned_int(cast(*u32) local_input.data, local_input.length)
        );
        {
            i: u32 = 0;
            while i < local_input.length {
                ifloat_flip(radix_sort_2, cast(*u32) ((cast(**float32) *(index_explicit_32(*local_input, i))).*));
                i += 1;
            }
        }
    }
}

index_explicit_32 :: (using const_array_view: *Const_Array_View(float32), index: u32) -> *float32 {
    assert(index < length);
    return *data[index];
}

ifloat_flip :: (using radix_sort_2: *Radix_Sort, f: *u32) {
    mask := (f.* >> 31 - 1) | 0x80000000;
    c_transpiler_compound_xor(*(((cast(**u32) *(f)).*).*), (mask), u32, u32);
}

radix_sort :: (using radix_sort_2: *Radix_Sort, input: Const_Array_View(u32)) {
    P: u32 = 4;

    histogram: [1024] u32 = ---;
    link: [256] *u32 = ---;
    create_histograms(radix_sort_2, input, histogram.data);

    if 0 < P {
        for j: 0..P - 1 {
            h := histogram.data + j * 256;
            input_bytes := cast(*u8) input.data;
            input_bytes += j;
            if h[input_bytes[0]] == input.length {
                continue;
            }

            link[0] = ranks2;
            if 1 < 256 {
                for i_4: 1..cast(u32) 256 - 1 {
                    link[i_4] = link[i_4 - 1] + h[i_4 - 1];
                }
            }

            if !valid_ranks {
                {
                    i_3: u32 = 0;
                    while i_3 < input.length {
                        link[input_bytes[i_3 * P]].* = i_3;
                        link[input_bytes[i_3 * P]] += 1;
                        i_3 += 1;
                    }
                }
                valid_ranks = true;
            } else {
                {
                    i_2: u32 = 0;
                    while i_2 < input.length {
                        IDX := ranks[i_2];
                        link[input_bytes[IDX * P]].* = IDX;
                        link[input_bytes[IDX * P]] += 1;
                        i_2 += 1;
                    }
                }
            }

            internal_swap(*ranks, *ranks2);
        }
    }

    if !valid_ranks {
        {
            i: u32 = 0;
            while i < input.length {
                ranks[i] = i;
                i += 1;
            }
        }
        valid_ranks = true;
    }
}

internal_swap :: (a: **u32, b: **u32) {
    temp := (cast(**u32) a).*;
    assignment_20: *u32 = (cast(**u32) b).*;
    ((cast(**u32) a).*) = assignment_20;
    assignment_21: *u32 = temp;
    ((cast(**u32) b).*) = assignment_21;
}

create_histograms :: (using radix_sort_2: *Radix_Sort, input: Const_Array_View(u32), histogram: *u32) {
    BUCKET_COUNT: u32 = 4;

    h: [4] *u32 = ---;
    if 0 < BUCKET_COUNT {
        for i: 0..BUCKET_COUNT - 1 {
            h[i] = histogram + 256 * i;
        }
    }

    fill_memory(histogram, 0, (cast(u64) (256 * BUCKET_COUNT)) * 4);

    p := cast(*u8) input.data;
    pe := p + (cast(u64) input.length) * 4;
    while p != pe {
        h[0][(c_transpiler_post_increment(*(p))).*] += 1;
        h[1][(c_transpiler_post_increment(*(p))).*] += 1;
        h[2][(c_transpiler_post_increment(*(p))).*] += 1;
        h[3][(c_transpiler_post_increment(*(p))).*] += 1;
    }
}

float_flip :: (using radix_sort_2: *Radix_Sort, f: *u32) {
    mask := cast,no_check(s32) ((cast,no_check(u32) ((cast,no_check(s32) f.*) >> 31)) | 0x80000000);
    c_transpiler_compound_xor(*(((cast(**u32) *(f)).*).*), (cast,no_check(u32) mask), u32, u32);
}

insertion_sort :: (using radix_sort_2: *Radix_Sort, input: Const_Array_View(float32)) {
    local_input: Const_Array_View(float32) = input;
    if !valid_ranks {
        ranks[0] = 0;
        {
            i_2: u32 = 1;
            while i_2 != local_input.length {
                rank_2 :=
                    cast,no_check(s32) ((ifx true { assignment_22: u32 = cast,no_check(u32) (i_2); (ranks[i_2]) = assignment_22; assignment_22; }));
                j_2 := i_2;
                while j_2 != 0 && ((cast(**float32) *(index_explicit_32(*local_input, cast,no_check(u32) rank_2))).*).* < ((cast(**float32) *(index_explicit_32(*local_input, ranks[j_2 - 1]))).*).* {
                    ranks[j_2] = ranks[j_2 - 1];
                    j_2 -= 1;
                }
                if i_2 != j_2 {
                    ranks[j_2] = cast,no_check(u32) rank_2;
                }
                i_2 += 1;
            }
        }
        valid_ranks = true;
    } else {
        {
            i: u32 = 1;
            while i != local_input.length {
                rank := cast,no_check(s32) ranks[i];
                j := i;
                while j != 0 && ((cast(**float32) *(index_explicit_32(*local_input, cast,no_check(u32) rank))).*).* < ((cast(**float32) *(index_explicit_32(*local_input, ranks[j - 1]))).*).* {
                    ranks[j] = ranks[j - 1];
                    j -= 1;
                }
                if i != j {
                    ranks[j] = cast,no_check(u32) rank;
                }
                i += 1;
            }
        }
    }
}

multiply_assign :: (using vector2: *Vector2, s: float32) {
    x *= s;
    y *= s;
}

subtract_assign :: (using vector2: *Vector2, v: *Vector2) {
    x -= v.x;
    y -= v.y;
}

internal_dot :: (a: *Vector2, b: *Vector2) -> float32 {
    return a.x * b.x + a.y * b.y;
}

resize :: (using array: *Array(Vector2), new_size: u32) {
    resize(*base, new_size, true);
}

internal_square :: (f: float32) -> float32 {
    return f * f;
}

add_charts :: (using atlas: *Pack_Atlas, task_scheduler: *Task_Scheduler, param_atlas: *Param_Atlas) {
    chart_count_2: u32 = 0;
    {
        i_3: u32 = 0;
        while i_3 < mesh_count(param_atlas) {
            CHART_GROUPS_COUNT_2 := chart_group_count(param_atlas, i_3);
            if 0 < CHART_GROUPS_COUNT_2 {
                for j_2: 0..CHART_GROUPS_COUNT_2 - 1 {
                    chart_group_2: *Chart_Group = cast,no_check(*Chart_Group) chart_group_at(param_atlas, i_3, j_2);
                    chart_count_2 += chart_count(chart_group_2);
                }
            }
            i_3 += 1;
        }
    }
    if chart_count_2 == 0 {
        return;
    }

    bounding_box: Thread_Local(Bounding_Box2_D) = ---;
    defer deinit(*bounding_box);
    init(*bounding_box);
    task_group := create_task_group(task_scheduler, cast(*void) *bounding_box, chart_count_2);
    task_args: Array(Add_Chart_Task_Args) = ---;
    defer deinit(*task_args);
    init(*task_args, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*task_args, chart_count_2);
    chart_index: u32 = 0;
    {
        i_2: u32 = 0;
        while i_2 < mesh_count(param_atlas) {
            CHART_GROUPS_COUNT := chart_group_count(param_atlas, i_2);
            if 0 < CHART_GROUPS_COUNT {
                for j: 0..CHART_GROUPS_COUNT - 1 {
                    chart_group: *Chart_Group = cast,no_check(*Chart_Group) chart_group_at(param_atlas, i_2, j);
                    COUNT := chart_count(chart_group);
                    if 0 < COUNT {
                        for k: 0..COUNT - 1 {
                            args: *Add_Chart_Task_Args =
                                cast,no_check(*Add_Chart_Task_Args) index_explicit_33(
                                    *task_args,
                                    chart_index
                                );
                            args.param_chart = cast,no_check(*Param_Chart) chart_at(chart_group, k);
                            task: Task = ---;
                            task.user_data =
                                cast(*void) ((cast(**Add_Chart_Task_Args) *(index_explicit_33(
                                    *task_args,
                                    chart_index
                                ))).*);
                            task.func = internal_pack_run_add_chart_task;
                            run(task_scheduler, task_group, task);
                            chart_index += 1;
                        }
                    }
                }
            }
            i_2 += 1;
        }
    }
    wait(task_scheduler, *task_group);

    resize(*charts, chart_count_2);
    if 0 < chart_count_2 {
        for i: 0..chart_count_2 - 1 {
            assignment_23: *Pack_Chart = cast,no_check(*Pack_Chart) ((index_explicit_33(*task_args, i)).chart);
            ((cast(**Pack_Chart) index_explicit_3(*charts, i)).*) = assignment_23;
        }
    }
}

index_explicit_33 :: (using array: *Array(Add_Chart_Task_Args), index: u32) -> *Add_Chart_Task_Args {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Add_Chart_Task_Args) base.buffer)[index];
}

resize :: (using array: *Array(*Pack_Chart), new_size: u32) {
    resize(*base, new_size, true);
}

wait :: (using task_scheduler: *Task_Scheduler, handle: *Task_Group_Handle) {
    if handle.value == 4294967295 {
        assert(false);
        return;
    }
    group: *Task_Scheduler_Task_Group =
        cast,no_check(*Task_Scheduler_Task_Group) ((cast(**Task_Scheduler_Task_Group) index_explicit_34(*groups, handle.value)).*);
    {
        i: u32 = 0;
        while i < size(*group.queue) {
            (index_explicit_35(*group.queue, i)).func(group.user_data, (index_explicit_35(*group.queue, i)).user_data);
            i += 1;
        }
    }
    clear(*group.queue);
    destroy_group(task_scheduler, handle.*);
    handle.value = 4294967295;
}

destroy_group :: (using task_scheduler: *Task_Scheduler, handle: Task_Group_Handle) {
    group: *Task_Scheduler_Task_Group =
        cast,no_check(*Task_Scheduler_Task_Group) ((cast(**Task_Scheduler_Task_Group) index_explicit_34(*groups, handle.value)).*);
    if group != null {
        deinit(group);
        internal_realloc(
            cast(*void) group,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            3356
        );
        (cast(**Task_Scheduler_Task_Group) index_explicit_34(*groups, handle.value)).* =
            cast(*Task_Scheduler_Task_Group) null;
    }
}

index_explicit_34 :: (using array: *Array(*Task_Scheduler_Task_Group), index: u32) -> **Task_Scheduler_Task_Group {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Task_Scheduler_Task_Group) base.buffer)[index];
}

deinit :: (using task_group: *Task_Scheduler_Task_Group) {
    cpp_transpiler_subobject_cleanup_g29: bool = ---;
    defer deinit(*queue);
}

clear :: (using array: *Array(Task)) {
    clear(*base);
}

index_explicit_35 :: (using array: *Array(Task), index: u32) -> *Task {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Task) base.buffer)[index];
}

size :: (using array: *Array(Task)) -> u32 {
    return base.size;
}

run :: (using task_scheduler: *Task_Scheduler, handle: Task_Group_Handle, task: Task) {
    local_task: Task = task;
    push_back(*(((cast(**Task_Scheduler_Task_Group) index_explicit_34(*groups, handle.value)).*).queue), *local_task);
}

push_back :: (using array: *Array(Task), value: *Task) {
    push_back(*base, cast(*u8) ((cast(**Task) *(value)).*));
}

internal_pack_run_add_chart_task :: (group_user_data: *void, task_user_data: *void) {
    bounding_box := cast(*Thread_Local(Bounding_Box2_D)) group_user_data;
    args := cast(*Add_Chart_Task_Args) task_user_data;
    param_chart := args.param_chart;

    restore_texcoords(param_chart);

    mesh := unified_mesh_2(param_chart);
    args.chart =
        (ifx true {
        cpp_transpiler_new_g30 :=
            cast(*Pack_Chart) (cast(*void) (cast(*Pack_Chart) internal_realloc(
                null,
                136,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                8110
            )));
        init(cpp_transpiler_new_g30);
        cpp_transpiler_new_g30;
    })
;
    chart := args.chart;
    chart.atlas_index = -1;
    chart.material = 0;
    chart.indices = indices(mesh);
    chart.parametric_area = compute_parametric_area(mesh);
    if chart.parametric_area < K_AREA_EPSILON {
        BOUNDS := compute_parametric_bounds(param_chart);
        chart.parametric_area = BOUNDS.x * BOUNDS.y;
    }
    chart.surface_area = compute_surface_area(mesh);
    chart.vertices = texcoords(mesh);
    chart.boundary_edges = cast,no_check(*Array(u32)) ((cast(**Array(u32)) *(boundary_edges(mesh))).*);

    bb: *Bounding_Box2_D = cast,no_check(*Bounding_Box2_D) get(bounding_box);
    clear(bb);
    {
        v: u32 = 0;
        while v < chart.vertices.length {
            if is_boundary_vertex(mesh, v) {
                append_boundary_vertex(bb, ((cast(**Vector2) *(texcoord(mesh, v))).*).*);
            }
            v += 1;
        }
    }
    compute(bb, make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2(texcoords(mesh)));
    assign_3(*chart.major_axis, *bb.major_axis);
    assign_3(*chart.minor_axis, *bb.minor_axis);
    assign_3(*chart.min_corner, *bb.min_corner);
    assign_3(*chart.max_corner, *bb.max_corner);
}

get :: (using thread_local: *Thread_Local(Bounding_Box2_D)) -> *Bounding_Box2_D {
    return *array[current_thread_index()];
}

current_thread_index :: () -> u32 {
    return 0;
}

unified_mesh_2 :: (using chart: *Param_Chart) -> *Internal_Mesh {
    return unified_mesh;
}

compute :: (using bounding_box2_d: *Bounding_Box2_D, vertices_2: Const_Array_View(Vector2)) {
    local_vertices_2: Const_Array_View(Vector2) = vertices_2;
    assert(!is_empty(*boundary_vertices));
    if local_vertices_2.length == 0 {
        assign_4(*local_vertices_2, *boundary_vertices);
    }
    convex_hull(
        bounding_box2_d,
        make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2(*boundary_vertices),
        *hull,
        0.00001
    );

    best_area: float32 = cast(float32) 3.40282347e+38;
    best_min: Vector2 = make_vector2(0);
    best_max: Vector2 = make_vector2(0);
    best_axis: Vector2 = make_vector2(0);
    HULL_COUNT := size(*hull);
    {
        i: u32 = 0;
        j := HULL_COUNT - 1;
        while i < HULL_COUNT {
            if internal_equal(index_explicit_4(*hull, i), index_explicit_4(*hull, j), K_EPSILON) {
                j = i;
                i += 1;
                continue;
            }
            axis :=
                internal_normalize(
                    (ifx true { temporary___g0: Vector2 = internal_operator(index_explicit_4(*hull, i), index_explicit_4(*hull, j)); *temporary___g0; })
                );
            assert(internal_is_finite(*axis));

            box_min: Vector2 = make_vector2(cast(float32) 3.40282347e+38, cast(float32) 3.40282347e+38);
            box_max: Vector2 = make_vector2(-cast(float32) 3.40282347e+38, -cast(float32) 3.40282347e+38);

            {
                v: u32 = 0;
                while v < local_vertices_2.length {
                    point: *Vector2 = cast,no_check(*Vector2) index_explicit_13(*local_vertices_2, v);
                    X := internal_dot(*axis, point);
                    Y :=
                        internal_dot(
                            (ifx true { temporary___g1: Vector2 = make_vector2(-axis.y, axis.x); *temporary___g1; }),
                            point
                        );
                    box_min.x = internal_min(*box_min.x, *X);
                    box_max.x = internal_max(*box_max.x, *X);
                    box_min.y = internal_min(*box_min.y, *Y);
                    box_max.y = internal_max(*box_max.y, *Y);
                    v += 1;
                }
            }

            AREA := (box_max.x - box_min.x) * (box_max.y - box_min.y);
            if AREA < best_area {
                best_area = AREA;
                assign_3(*best_min, *box_min);
                assign_3(*best_max, *box_max);
                assign_3(*best_axis, *axis);
            }
            j = i;
            i += 1;
        }
    }
    assign_3(*major_axis, *best_axis);
    assign(
        *minor_axis,
        (ifx true { temporary___g2: Vector2 = make_vector2(-best_axis.y, best_axis.x); *temporary___g2; })
    );
    assign_3(*min_corner, *best_min);
    assign_3(*max_corner, *best_max);
    if !(internal_is_finite(*major_axis) && internal_is_finite(*minor_axis) && internal_is_finite(*min_corner)) {
        if s_print != null {
            s_print(
                c_string("\rASSERT: %s %s %d\n"),
                c_string("isFinite(majorAxis) && isFinite(minorAxis) && isFinite(minCorner)"),
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                cast(s32) 2285
            );
        }
    }
}

internal_is_finite :: (v: *Vector2) -> bool {
    return internal_is_finite(v.x) && internal_is_finite(v.y);
}

internal_equal :: (v1: *Vector2, v2: *Vector2, epsilon_2: float32) -> bool {
    return internal_equal(v1.x, v2.x, epsilon_2) && internal_equal(v1.y, v2.y, epsilon_2);
}

convex_hull :: (
    using bounding_box2_d: *Bounding_Box2_D,
    input: Const_Array_View(Vector2),
    output: *Array(Vector2),
    epsilon_2: float32
) {
    local_input: Const_Array_View(Vector2) = input;
    resize(*coords, local_input.length);
    {
        i_5: u32 = 0;
        while i_5 < local_input.length {
            assignment_24: float32 = (index_explicit_13(*local_input, i_5)).x;
            (((cast(**float32) *(index_explicit_26(*coords, i_5))).*).*) = assignment_24;
            i_5 += 1;
        }
    }
    sort(*radix, make_struct_xatlas_internal_const_array_view_float(*coords));
    ranks_2 := ranks(*radix);
    clear(*top);
    clear(*bottom);
    reserve(*top, local_input.length);
    reserve(*bottom, local_input.length);
    p_3: Vector2 = ((cast(**Vector2) *(index_explicit_13(*local_input, ranks_2[0]))).*).*;
    q: Vector2 = ((cast(**Vector2) *(index_explicit_13(*local_input, ranks_2[local_input.length - 1]))).*).*;
    topy := internal_max(*p_3.y, *q.y);
    boty := internal_min(*p_3.y, *q.y);
    {
        i_4: u32 = 0;
        while i_4 < local_input.length {
            p_2: Vector2 = ((cast(**Vector2) *(index_explicit_13(*local_input, ranks_2[i_4]))).*).*;
            if p_2.y >= boty {
                push_back(*top, *p_2);
            }
            i_4 += 1;
        }
    }
    {
        i_3: u32 = 0;
        while i_3 < local_input.length {
            p: Vector2 =
                ((cast(**Vector2) *(index_explicit_13(*local_input, ranks_2[(local_input.length - 1) -
                    i_3]))).*).*;
            if p.y <= topy {
                push_back(*bottom, *p);
            }
            i_3 += 1;
        }
    }

    clear(output);
    assert(size(*top) >= 2);
    push_back(output, index_explicit_4(*top, 0));
    push_back(output, index_explicit_4(*top, 1));
    {
        i_2: u32 = 2;
        while i_2 < size(*top) {
            a_2 := ((cast(**Vector2) *(index_explicit_4(output, size(output) - 2))).*).*;
            b_2 := ((cast(**Vector2) *(index_explicit_4(output, size(output) - 1))).*).*;
            c__ := ((cast(**Vector2) *(index_explicit_4(*top, i_2))).*).*;
            area_3 := internal_triangle_area(*a_2, *b_2, *c__);
            if area_3 >= -epsilon_2 {
                pop_back(output);
            }
            if area_3 < -epsilon_2 || size(output) == 1 {
                push_back(output, *c__);
                i_2 += 1;
            }
        }
    }
    top_count := size(output);
    assert(size(*bottom) >= 2);
    push_back(output, index_explicit_4(*bottom, 1));

    {
        i: u32 = 2;
        while i < size(*bottom) {
            a := ((cast(**Vector2) *(index_explicit_4(output, size(output) - 2))).*).*;
            b := ((cast(**Vector2) *(index_explicit_4(output, size(output) - 1))).*).*;
            c_ := ((cast(**Vector2) *(index_explicit_4(*bottom, i))).*).*;
            area_2 := internal_triangle_area(*a, *b, *c_);
            if area_2 >= -epsilon_2 {
                pop_back(output);
            }
            if area_2 < -epsilon_2 || size(output) == top_count {
                push_back(output, *c_);
                i += 1;
            }
        }
    }

    assert(size(output) > 0);
    pop_back(output);
}

pop_back :: (using array: *Array(Vector2)) {
    pop_back(*base);
}

push_back :: (using array: *Array(Vector2), value: *Vector2) {
    push_back(*base, cast(*u8) ((cast(**Vector2) *(value)).*));
}

internal_triangle_area :: (a: *Vector2, b: *Vector2, c_: *Vector2) -> float32 {
    V0 := internal_operator(a, c_);
    V1 := internal_operator(b, c_);
    return (V0.x * V1.y - V0.y * V1.x) * 0.5;
}

clear :: (using array: *Array(Vector2)) {
    clear(*base);
}

reserve :: (using array: *Array(Vector2), desired_size: u32) {
    reserve(*base, desired_size);
}

assign_4 :: (const_array_view: *Const_Array_View(Vector2), a: *Array(Vector2)) -> *Const_Array_View(Vector2) {
    const_array_view.data = cast,no_check(*Vector2) data(a);
    const_array_view.length = size(a);
    return const_array_view;
}

data :: (using array: *Array(Vector2)) -> *Vector2 {
    return cast(*Vector2) base.buffer;
}

is_empty :: (using array: *Array(Vector2)) -> bool {
    return base.size == 0;
}

append_boundary_vertex :: (using bounding_box2_d: *Bounding_Box2_D, v: Vector2) {
    local_v: Vector2 = v;
    push_back(*boundary_vertices, *local_v);
}

is_boundary_vertex :: (using mesh: *Internal_Mesh, vertex: u32) -> bool {
    return get(*is_boundary_vertex, vertex);
}

clear :: (using bounding_box2_d: *Bounding_Box2_D) {
    clear(*boundary_vertices);
}

boundary_edges :: (using mesh: *Internal_Mesh) -> *Array(u32) {
    return *boundary_edges;
}

compute_surface_area :: (using mesh: *Internal_Mesh) -> float32 {
    area_2: float32 = 0;
    {
        f: u32 = 0;
        while f < face_count(mesh) {
            area_2 += compute_face_area(mesh, f);
            f += 1;
        }
    }
    assert(area_2 >= 0);
    return area_2;
}

compute_face_area :: (using mesh: *Internal_Mesh, face_2: u32) -> float32 {
    p0: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 0))).*).*
        );
    p1: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 1))).*).*
        );
    p2: *Vector3 =
        cast,no_check(*Vector3) index_explicit_9(
            *positions,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 2))).*).*
        );
    return internal_length(
        (ifx true { temporary___g2: Vector3 = internal_cross(
        (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(p1, p0); *temporary___g0; }),
        (ifx true { temporary___g1: Vector3 = internal_operator_in_xatlas_2(p2, p0); *temporary___g1; })
    ); *temporary___g2; })
    ) * 0.5;
}

compute_parametric_area :: (using mesh: *Internal_Mesh) -> float32 {
    area_2: float32 = 0;
    {
        f: u32 = 0;
        while f < face_count(mesh) {
            area_2 += fabsf(compute_face_parametric_area(mesh, f));
            f += 1;
        }
    }
    return area_2;
}

compute_face_parametric_area :: (using mesh: *Internal_Mesh, face_2: u32) -> float32 {
    t0: *Vector2 =
        cast,no_check(*Vector2) index_explicit_18(
            *texcoords,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 0))).*).*
        );
    t1: *Vector2 =
        cast,no_check(*Vector2) index_explicit_18(
            *texcoords,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 1))).*).*
        );
    t2: *Vector2 =
        cast,no_check(*Vector2) index_explicit_18(
            *texcoords,
            ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + 2))).*).*
        );
    return internal_triangle_area(t0, t1, t2);
}

restore_texcoords :: (using chart: *Param_Chart) {
    copy_memory((texcoords(unified_mesh)).data, data_2(*backup_texcoords), (cast(u64) vertex_count(unified_mesh)) * 8);
}

data_2 :: (using array: *Array(Vector2)) -> *Vector2 {
    return cast(*Vector2) base.buffer;
}

mesh_count :: (using atlas: *Param_Atlas) -> u32 {
    return size(*meshes);
}

resize :: (using array: *Array(Add_Chart_Task_Args), new_size: u32) {
    resize(*base, new_size, true);
}

add_uv_mesh_charts :: (using atlas: *Pack_Atlas, mesh: *Uv_Mesh_Instance) {
    resize(*mesh.texcoords, size(*mesh.mesh.texcoords));
    copy_memory(data_2(*mesh.texcoords), data_2(*mesh.mesh.texcoords), (cast(u64) size(*mesh.texcoords)) * 8);
    vertex_used: Bit_Array = ---;
    defer deinit(*vertex_used);
    init(*vertex_used, size(*mesh.texcoords));
    bounding_box: Bounding_Box2_D = ---;
    defer deinit(*bounding_box);
    init(*bounding_box);
    {
        c_: u32 = 0;
        while c_ < size(*mesh.mesh.charts) {
            uv_chart: *Uv_Mesh_Chart =
                cast,no_check(*Uv_Mesh_Chart) ((cast(**Uv_Mesh_Chart) index_explicit_36(*mesh.mesh.charts, c_)).*);
            chart :=
                cast(*Pack_Chart) (cast(*void) (cast(*Pack_Chart) internal_realloc(
                    null,
                    136,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    8216
                )));
            init(chart);
            chart.atlas_index = -1;
            chart.material = uv_chart.material;
            assign_6(*chart.indices, *uv_chart.indices);
            assign_5(*chart.vertices, *mesh.texcoords);
            chart.boundary_edges = cast(*Array(u32)) null;
            resize(*chart.faces, size(*uv_chart.faces));
            copy_memory(data(*chart.faces), data(*uv_chart.faces), 4 * cast(u64) size(*uv_chart.faces));

            zero_out_memory(*vertex_used);
            {
                i: u32 = 0;
                while i < chart.indices.length {
                    VERTEX: u32 = ((cast(**u32) *(index_explicit_12(*chart.indices, i))).*).*;
                    if !get(*vertex_used, VERTEX) {
                        set(*vertex_used, VERTEX);
                        push_back(*chart.unique_vertices, *VERTEX);
                    }
                    i += 1;
                }
            }

            chart.parametric_area = 0.0;
            {
                f: u32 = 0;
                while f < chart.indices.length / 3 {
                    v1: *Vector2 =
                        cast,no_check(*Vector2) index_explicit_2(
                            *chart.vertices,
                            ((cast(**u32) *(index_explicit_12(*chart.indices, (f * 3) + 0))).*).*
                        );
                    v2: *Vector2 =
                        cast,no_check(*Vector2) index_explicit_2(
                            *chart.vertices,
                            ((cast(**u32) *(index_explicit_12(*chart.indices, (f * 3) + 1))).*).*
                        );
                    v3: *Vector2 =
                        cast,no_check(*Vector2) index_explicit_2(
                            *chart.vertices,
                            ((cast(**u32) *(index_explicit_12(*chart.indices, (f * 3) + 2))).*).*
                        );
                    chart.parametric_area += fabsf(internal_triangle_area(v1, v2, v3));
                    f += 1;
                }
            }
            chart.parametric_area *= 0.5;
            if chart.parametric_area < K_AREA_EPSILON {
                min_corner: Vector2 = make_vector2(cast(float32) 3.40282347e+38, cast(float32) 3.40282347e+38);
                max_corner: Vector2 = make_vector2(-cast(float32) 3.40282347e+38, -cast(float32) 3.40282347e+38);
                {
                    v_2: u32 = 0;
                    while v_2 < unique_vertex_count(chart) {
                        assign(
                            *min_corner,
                            (ifx true { temporary___g0: Vector2 = internal_min(*min_corner, unique_vertex_at(chart, v_2)); *temporary___g0; })
                        );
                        assign(
                            *max_corner,
                            (ifx true { temporary___g1: Vector2 = internal_max(*max_corner, unique_vertex_at(chart, v_2)); *temporary___g1; })
                        );
                        v_2 += 1;
                    }
                }
                BOUNDS :=
                    internal_operator(
                        (ifx true { temporary___g2: Vector2 = internal_operator(*max_corner, *min_corner); *temporary___g2; }),
                        0.5
                    );
                chart.parametric_area = BOUNDS.x * BOUNDS.y;
            }
            assert(internal_is_finite(chart.parametric_area));
            assert(!internal_is_nan(chart.parametric_area));
            chart.surface_area = chart.parametric_area;

            clear(*bounding_box);
            {
                v: u32 = 0;
                while v < unique_vertex_count(chart) {
                    append_boundary_vertex(*bounding_box, ((cast(**Vector2) *(unique_vertex_at(chart, v))).*).*);
                    v += 1;
                }
            }
            compute(*bounding_box, Const_Array_View(Vector2).{});
            assign_3(*chart.major_axis, *bounding_box.major_axis);
            assign_3(*chart.minor_axis, *bounding_box.minor_axis);
            assign_3(*chart.min_corner, *bounding_box.min_corner);
            assign_3(*chart.max_corner, *bounding_box.max_corner);
            push_back(*charts, *chart);
            c_ += 1;
        }
    }
}

push_back :: (using array: *Array(*Pack_Chart), value: **Pack_Chart) {
    push_back(*base, cast(*u8) (cast(**Pack_Chart) value));
}

internal_is_nan :: (f: float32) -> bool {
    return f != f;
}

index_explicit_36 :: (using array: *Array(*Uv_Mesh_Chart), index: u32) -> **Uv_Mesh_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Uv_Mesh_Chart) base.buffer)[index];
}

assign_5 :: (using array_view: *Array_View(Vector2), a: *Array(Vector2)) -> *Array_View(Vector2) {
    data = cast,no_check(*Vector2) data_2(a);
    length = size(a);
    return array_view;
}

assign_6 :: (using const_array_view: *Const_Array_View(u32), a: *Array(u32)) -> *Const_Array_View(u32) {
    data = cast,no_check(*u32) data_3(a);
    length = size(a);
    return const_array_view;
}

data_3 :: (using array: *Array(u32)) -> *u32 {
    return cast(*u32) base.buffer;
}

charts_computed :: (using atlas: *Param_Atlas) -> bool {
    return charts_computed;
}

index_explicit_37 :: (using array: *Array(*Uv_Mesh), index: u32) -> **Uv_Mesh {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Uv_Mesh) base.buffer)[index];
}

size :: (using array: *Array(*Uv_Mesh)) -> u32 {
    return base.size;
}

quality :: (using chart: *Param_Chart) -> *Quality {
    return *quality;
}

generator_type :: (using chart: *Param_Chart) -> Chart_Generator_Type_Enum {
    return generator_type;
}

tjunction_count :: (using chart: *Param_Chart) -> u32 {
    return tjunction_count;
}

compute_charts :: (
    using atlas_2: *Param_Atlas,
    task_scheduler: *Task_Scheduler,
    options_: *Chart_Options,
    progress_func: Progress_Func,
    progress_user_data: *void
) -> bool {
    MESH_COUNT := size(*meshes);
    total_face_count: u32 = 0;
    if 0 < MESH_COUNT {
        for i_5: 0..MESH_COUNT - 1 {
            total_face_count += face_count((cast(**Internal_Mesh) index_explicit_54(*meshes, i_5)).*);
        }
    }
    progress: Progress = ---;
    defer deinit(*progress);
    init(
        *progress,
        PROGRESS_CATEGORY_COMPUTE_CHARTS,
        cast,no_check(Progress_Func) (progress_func),
        progress_user_data,
        total_face_count * 2
    );
    charts_computed = false;

    if !is_empty(*mesh_chart_groups) {
        {
            i_4: u32 = 0;
            while i_4 < size(*mesh_chart_groups) {
                {
                    j: u32 = 0;
                    while j < size(index_explicit_56(*mesh_chart_groups, i_4)) {
                        deinit((cast(**Chart_Group) index_explicit_52(index_explicit_56(*mesh_chart_groups, i_4), j)).*);
                        internal_realloc(
                            cast(*void) ((cast(**Chart_Group) index_explicit_52(index_explicit_56(*mesh_chart_groups, i_4), j)).*),
                            0,
                            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                            7911
                        );
                        j += 1;
                    }
                }
                clear(index_explicit_56(*mesh_chart_groups, i_4));
                i_4 += 1;
            }
        }
        if !(size(*mesh_chart_groups) == MESH_COUNT) {
            if s_print != null {
                s_print(
                    c_string("\rASSERT: %s %s %d\n"),
                    c_string("m_meshChartGroups.size() == meshCount"),
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    cast(s32) 7915
                );
            }
        }
    }
    resize(*mesh_chart_groups, MESH_COUNT);
    run_ctors(*mesh_chart_groups);
    resize(*invalid_mesh_geometry, MESH_COUNT);
    run_ctors(*invalid_mesh_geometry);

    task_args: Array(Mesh_Compute_Charts_Task_Args) = ---;
    defer deinit(*task_args);
    init(*task_args, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*task_args, MESH_COUNT);
    if 0 < MESH_COUNT {
        for i_3: 0..MESH_COUNT - 1 {
            args: *Mesh_Compute_Charts_Task_Args =
                cast,no_check(*Mesh_Compute_Charts_Task_Args) index_explicit_53(
                    *task_args,
                    i_3
                );
            args.source_mesh =
                cast,no_check(*Internal_Mesh) ((cast(**Internal_Mesh) index_explicit_54(*meshes, i_3)).*);
            args.chart_groups =
                cast,no_check(*Array(*Chart_Group)) ((cast(**Array(*Chart_Group)) *(index_explicit_56(*mesh_chart_groups, i_3))).*);
            args.invalid_mesh_geometry =
                cast,no_check(*Invalid_Mesh_Geometry) ((cast(**Invalid_Mesh_Geometry) *(index_explicit_55(
                    *invalid_mesh_geometry,
                    i_3
                ))).*);
        }
    }

    mesh_sort_data: Array(float32) = ---;
    defer deinit(*mesh_sort_data);
    init(*mesh_sort_data, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*mesh_sort_data, MESH_COUNT);
    if 0 < MESH_COUNT {
        for i_2: 0..MESH_COUNT - 1 {
            assignment_25: float32 =
                cast,no_check(float32) index_count((cast(**Internal_Mesh) index_explicit_54(*meshes, i_2)).*);
            (((cast(**float32) *(index_explicit_26(*mesh_sort_data, i_2))).*).*) = assignment_25;
        }
    }
    mesh_sort: Radix_Sort = ---;
    defer deinit(*mesh_sort);
    init(*mesh_sort);
    sort(*mesh_sort, make_struct_xatlas_internal_const_array_view_float(*mesh_sort_data));

    atlas: Thread_Local(Segment_Atlas) = ---;
    defer deinit(*atlas);
    init(*atlas);
    boundary_grid: Thread_Local(Uniform_Grid2) = ---;
    defer deinit(*boundary_grid);
    init(*boundary_grid);
    chart_buffers: Thread_Local(Chart_Ctor_Buffers) = ---;
    defer deinit(*chart_buffers);
    init(*chart_buffers);
    piecewise_param: Thread_Local(Piecewise_Param) = ---;
    defer deinit(*piecewise_param);
    init(*piecewise_param);
    task_group_args: Mesh_Compute_Charts_Task_Group_Args = ---;
    task_group_args.atlas = cast,no_check(*Thread_Local(Segment_Atlas)) *atlas;
    task_group_args.options = (cast(**Chart_Options) *(options_)).*;
    task_group_args.progress = *progress;
    task_group_args.task_scheduler = task_scheduler;
    task_group_args.boundary_grid = cast,no_check(*Thread_Local(Uniform_Grid2)) *boundary_grid;
    task_group_args.chart_buffers = cast,no_check(*Thread_Local(Chart_Ctor_Buffers)) *chart_buffers;
    task_group_args.piecewise_param = cast,no_check(*Thread_Local(Piecewise_Param)) *piecewise_param;
    task_group := create_task_group(task_scheduler, cast(*void) *task_group_args, MESH_COUNT);
    if 0 < MESH_COUNT {
        for i: 0..MESH_COUNT - 1 {
            task: Task = ---;
            task.user_data =
                cast(*void) ((cast(**Mesh_Compute_Charts_Task_Args) *(index_explicit_53(
                    *task_args,
                    (ranks(
                    *mesh_sort
                ))[MESH_COUNT - i - 1]
                ))).*);
            task.func = internal_param_run_mesh_compute_charts_task;
            run(task_scheduler, task_group, task);
        }
    }
    wait(task_scheduler, *task_group);

    if operator_bool(*progress.cancel) {
        return false;
    }
    charts_computed = true;
    return true;
}

operator_bool :: (using struct_atomic_bool: *struct_atomic_Bool) -> bool {
    return load(*base, STD_MEMORY_ORDER_SEQ_CST);
}

load :: inline (
    using struct_atomic_base_bool: *struct_atomic_base_Bool,
    m: std_memory_order
) -> std_atomic_base_bool_int_type {
    b := std_operator(m, STD_MEMORY_ORDER_MASK);
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_RELEASE)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                515,
                c_string("__int_type std::__atomic_base<bool>::load(memory_order) const [_ITp = bool]"),
                c_string("__b != memory_order_release")
            );
        }
        if !(false) break;
    }
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_ACQ_REL)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                516,
                c_string("__int_type std::__atomic_base<bool>::load(memory_order) const [_ITp = bool]"),
                c_string("__b != memory_order_acq_rel")
            );
        }
        if !(false) break;
    }

    return atomic_load(*i);
}

std_operator :: (m: std_memory_order, mod: std_memory_order_modifier) -> std_memory_order {
    return (m & cast,no_check(s32) mod);
}

internal_param_run_mesh_compute_charts_task :: (group_user_data: *void, task_user_data: *void) {
    group_args: *Mesh_Compute_Charts_Task_Group_Args = ---;
    args: *Mesh_Compute_Charts_Task_Args = ---;
    mesh_face_groups: *Mesh_Face_Groups = ---;
    CHART_GROUP_COUNT: u32 = ---;
    i_3: u32 = ---;
    chart_group_sort_data: Array(float32) = ---;
    c_transpiler_cleanup_active_2640: bool;
    defer if c_transpiler_cleanup_active_2640 { deinit(*chart_group_sort_data); }
    i_2: u32 = ---;
    chart_group_sort: Radix_Sort = ---;
    c_transpiler_cleanup_active_2638: bool;
    defer if c_transpiler_cleanup_active_2638 { deinit(*chart_group_sort); }
    task_group_args: Chart_Group_Compute_Charts_Task_Group_Args = ---;
    task_group: Task_Group_Handle = ---;
    i: u32 = ---;
    task: Task = ---;
    code_block_to_execute: s64 = 46;
    // The transpiler had to use this control-flow loop because the source code used a goto, which Jai does not support.
    while c_transpiler_dispatch := true {
        if code_block_to_execute < 0 break;
        if code_block_to_execute == {
            case 0; {
                code_block_to_execute = 3;
                continue c_transpiler_dispatch;
            }
            case 2; {
                deinit(mesh_face_groups);
                internal_realloc(
                    cast(*void) mesh_face_groups,
                    0,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    7860
                );
                break c_transpiler_dispatch;
            }
            case 3; {
                if mesh_face_groups != null code_block_to_execute = 2;
                else code_block_to_execute = -1;
                continue c_transpiler_dispatch;
            }
            case 4; {
                wait(group_args.task_scheduler, *task_group);
                code_block_to_execute = 0;
                continue c_transpiler_dispatch;
            }
            case 5; {
                if i < CHART_GROUP_COUNT code_block_to_execute = 10;
                else code_block_to_execute = 4;
                continue c_transpiler_dispatch;
            }
            case 10; {
                task.user_data =
                    cast(*void) ((cast(**Chart_Group) index_explicit_52(
                        args.chart_groups,
                        CHART_GROUP_COUNT - i - 1
                    )).*);
                task.func = internal_param_run_chart_group_compute_charts_task;
                run(group_args.task_scheduler, task_group, task);
                i += 1;
                code_block_to_execute = 5;
                continue c_transpiler_dispatch;
            }
            case 23; {
                c_transpiler_cleanup_active_2638 = true;
                init(*chart_group_sort);
                sort(*chart_group_sort, make_struct_xatlas_internal_const_array_view_float(*chart_group_sort_data));
                task_group_args.atlas = cast,no_check(*Thread_Local(Segment_Atlas)) group_args.atlas;
                task_group_args.options = group_args.options;
                task_group_args.progress = group_args.progress;
                task_group_args.task_scheduler = group_args.task_scheduler;
                task_group_args.boundary_grid = cast,no_check(*Thread_Local(Uniform_Grid2)) group_args.boundary_grid;
                task_group_args.chart_buffers =
                    cast,no_check(*Thread_Local(Chart_Ctor_Buffers)) group_args.chart_buffers;
                task_group_args.piecewise_param =
                    cast,no_check(*Thread_Local(Piecewise_Param)) group_args.piecewise_param;
                task_group = create_task_group(group_args.task_scheduler, cast(*void) *task_group_args, CHART_GROUP_COUNT);
                i = 0;
                code_block_to_execute = 5;
                continue c_transpiler_dispatch;
            }
            case 24; {
                if i_2 < CHART_GROUP_COUNT code_block_to_execute = 26;
                else code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 26; {
                assignment_26: float32 =
                    cast,no_check(float32) face_count((cast(**Chart_Group) index_explicit_52(args.chart_groups, i_2)).*);
                (((cast(**float32) *(index_explicit_26(*chart_group_sort_data, i_2))).*).*) = assignment_26;
                i_2 += 1;
                code_block_to_execute = 24;
                continue c_transpiler_dispatch;
            }
            case 31; {
                extract(args.invalid_mesh_geometry, args.source_mesh, mesh_face_groups);
                c_transpiler_cleanup_active_2640 = true;
                init(*chart_group_sort_data, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
                resize(*chart_group_sort_data, CHART_GROUP_COUNT);
                i_2 = 0;
                code_block_to_execute = 24;
                continue c_transpiler_dispatch;
            }
            case 32; {
                if i_3 < CHART_GROUP_COUNT code_block_to_execute = 34;
                else code_block_to_execute = 31;
                continue c_transpiler_dispatch;
            }
            case 34; {
                assignment_27: *Chart_Group =
                    cast,no_check(*Chart_Group) ((ifx true {
        cpp_transpiler_new_g31 :=
            cast(*Chart_Group) (cast(*void) (cast(*Chart_Group) internal_realloc(
                null,
                80,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                7820
            )));
        init(cpp_transpiler_new_g31, i_3, args.source_mesh, mesh_face_groups, i_3);
        cpp_transpiler_new_g31;
    })
    );
                ((cast(**Chart_Group) index_explicit_52(args.chart_groups, i_3)).*) = assignment_27;
                i_3 += 1;
                code_block_to_execute = 32;
                continue c_transpiler_dispatch;
            }
            case 36; {
                resize(args.chart_groups, CHART_GROUP_COUNT);
                i_3 = 0;
                code_block_to_execute = 32;
                continue c_transpiler_dispatch;
            }
            case 37; {
                code_block_to_execute = 0;
                continue c_transpiler_dispatch;
            }
            case 42; {
                mesh_face_groups = cast(*Mesh_Face_Groups) (cast(*void) (cast(*Mesh_Face_Groups) internal_realloc(
                    null,
                    104,
                    cast(s32) INTERNAL_MEM_TAG_MESH,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    7774
                )));
                init(mesh_face_groups, args.source_mesh);
                compute(mesh_face_groups);
                CHART_GROUP_COUNT = group_count(mesh_face_groups);
                if operator_bool(*group_args.progress.cancel) code_block_to_execute = 37;
                else code_block_to_execute = 36;
                continue c_transpiler_dispatch;
            }
            case 43; {
                return;
            }
            case 46; {
                group_args = cast(*Mesh_Compute_Charts_Task_Group_Args) group_user_data;
                args = cast(*Mesh_Compute_Charts_Task_Args) task_user_data;
                if operator_bool(*group_args.progress.cancel) code_block_to_execute = 43;
                else code_block_to_execute = 42;
                continue c_transpiler_dispatch;
            }
        }
        assert(false, tprint("invalid code block to execute %", code_block_to_execute));
        break;
    }
}

deinit :: (using mesh_face_groups: *Mesh_Face_Groups) {
    cpp_transpiler_subobject_cleanup_g32: bool = ---;
    defer deinit(*groups);
    cpp_transpiler_subobject_cleanup_g33: bool = ---;
    defer deinit(*first_face);
    cpp_transpiler_subobject_cleanup_g34: bool = ---;
    defer deinit(*next_face);
    cpp_transpiler_subobject_cleanup_g35: bool = ---;
    defer deinit(*face_count);
}

internal_param_run_chart_group_compute_charts_task :: (group_user_data: *void, task_user_data: *void) {
    args := cast(*Chart_Group_Compute_Charts_Task_Group_Args) group_user_data;
    chart_group := cast(*Chart_Group) task_user_data;
    if operator_bool(*args.progress.cancel) {
        return;
    }

    compute_charts(
        chart_group,
        args.task_scheduler,
        args.options,
        args.progress,
        get(args.atlas),
        args.boundary_grid,
        args.chart_buffers,
        args.piecewise_param
    );
}

get :: (using thread_local: *Thread_Local(Segment_Atlas)) -> *Segment_Atlas {
    return *array[current_thread_index()];
}

compute_charts :: (
    using chart_group: *Chart_Group,
    task_scheduler: *Task_Scheduler,
    options_: *Chart_Options,
    progress: *Progress,
    atlas: *Segment_Atlas,
    boundary_grid: *Thread_Local(Uniform_Grid2),
    chart_buffers: *Thread_Local(Chart_Ctor_Buffers),
    piecewise_param: *Thread_Local(Piecewise_Param)
) {
    {
        i_6: u32 = 0;
        while i_6 < size(*charts) {
            deinit((cast(**Param_Chart) index_explicit_39(*charts, i_6)).*);
            internal_realloc(
                cast(*void) ((cast(**Param_Chart) index_explicit_39(*charts, i_6)).*),
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                7519
            );
            i_6 += 1;
        }
    }

    mesh := create_mesh(chart_group);

    reset(atlas, mesh, options_);
    compute(atlas);

    increment(progress, face_count(chart_group));

    FACE_COUNT := face_count(mesh);
    deinit(mesh);
    internal_realloc(
        cast(*void) mesh,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        7570
    );

    if operator_bool(*progress.cancel) {
        return;
    }

    CHART_COUNT := chart_count(atlas);
    chart_faces_2: Array(u32) = ---;
    defer deinit(*chart_faces_2);
    init(*chart_faces_2, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*chart_faces_2, CHART_COUNT + FACE_COUNT);
    offset: u32 = 0;
    if 0 < CHART_COUNT {
        for i: 0..CHART_COUNT - 1 {
            faces_2 := chart_faces(atlas, i);
            assignment_28: u32 = faces_2.length;
            (((cast(**u32) *(index_explicit(*chart_faces_2, c_transpiler_post_increment(*(offset))))).*).*) = assignment_28;
            {
                j_2: u32 = 0;
                while j_2 < faces_2.length {
                    assignment_29: u32 =
                        ((cast(**u32) *(index_explicit(*face_to_source_face_map, ((cast(**u32) *(index_explicit_12(*faces_2, j_2))).*).*))).*).*;
                    (((cast(**u32) *(index_explicit(*chart_faces_2, c_transpiler_post_increment(*(offset))))).*).*) = assignment_29;
                    j_2 += 1;
                }
            }
        }
    }

    group_args: Create_And_Parameterize_Chart_Task_Group_Args = ---;
    group_args.progress = progress;
    group_args.boundary_grid = cast,no_check(*Thread_Local(Uniform_Grid2)) boundary_grid;
    group_args.chart_buffers = cast,no_check(*Thread_Local(Chart_Ctor_Buffers)) chart_buffers;
    group_args.options = (cast(**Chart_Options) *(options_)).*;
    group_args.pp = cast,no_check(*Thread_Local(Piecewise_Param)) piecewise_param;
    task_group := create_task_group(task_scheduler, cast(*void) *group_args, CHART_COUNT);
    task_args: Array(Create_And_Parameterize_Chart_Task_Args) = ---;
    defer deinit(*task_args);
    init(*task_args, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*task_args, CHART_COUNT);
    run_ctors(*task_args);
    offset = 0;
    if 0 < CHART_COUNT {
        for i_5: 0..CHART_COUNT - 1 {
            args_2: *Create_And_Parameterize_Chart_Task_Args =
                cast,no_check(*Create_And_Parameterize_Chart_Task_Args) index_explicit_38(
                    *task_args,
                    i_5
                );

            args_2.basis = (cast(**Basis) *(chart_basis(atlas, i_5))).*;
            args_2.chart_generator_type = chart_generator_type(atlas, i_5);

            args_2.chart = cast(*Param_Chart) null;
            args_2.chart_group_id = id;
            args_2.chart_id = i_5;
            CHART_FACE_COUNT: u32 =
                ((cast(**u32) *(index_explicit(*chart_faces_2, c_transpiler_post_increment(*(offset))))).*).*;
            args_2.faces = make_struct_xatlas_internal_const_array_view_unsigned_int(
                (cast(**u32) *(index_explicit(*chart_faces_2, offset))).*,
                CHART_FACE_COUNT
            );
            offset += CHART_FACE_COUNT;
            args_2.mesh = source_mesh;
            task: Task = ---;
            task.user_data = cast(*void) ((cast(**Create_And_Parameterize_Chart_Task_Args) *(args_2)).*);
            task.func = internal_param_run_create_and_parameterize_chart_task;
            run(task_scheduler, task_group, task);
        }
    }
    wait(task_scheduler, *task_group);

    new_chart_count: u32 = 0;
    if 0 < CHART_COUNT {
        for i_4: 0..CHART_COUNT - 1 {
            if is_invalid((index_explicit_38(*task_args, i_4)).chart) {
                new_chart_count += size(*((index_explicit_38(*task_args, i_4)).charts));
            } else {
                new_chart_count += 1;
            }
        }
    }
    resize(*charts, new_chart_count);

    current_2: u32 = 0;
    if 0 < CHART_COUNT {
        for i_3: 0..CHART_COUNT - 1 {
            chart := (index_explicit_38(*task_args, i_3)).chart;
            if is_invalid(chart) {
                deinit(chart);
                internal_realloc(
                    cast(*void) chart,
                    0,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    7639
                );
                continue;
            }
            assignment_30: *Param_Chart = cast,no_check(*Param_Chart) chart;
            ((cast(**Param_Chart) index_explicit_39(*charts, c_transpiler_post_increment(*(current_2)))).*) = assignment_30;
        }
    }

    if 0 < CHART_COUNT {
        for i_2: 0..CHART_COUNT - 1 {
            args: *Create_And_Parameterize_Chart_Task_Args =
                cast,no_check(*Create_And_Parameterize_Chart_Task_Args) index_explicit_38(
                    *task_args,
                    i_2
                );
            {
                j: u32 = 0;
                while j < size(*args.charts) {
                    assignment_31: *Param_Chart = (cast(**Param_Chart) index_explicit_39(*args.charts, j)).*;
                    ((cast(**Param_Chart) index_explicit_39(*charts, c_transpiler_post_increment(*(current_2)))).*) = assignment_31;
                    j += 1;
                }
            }
        }
    }

    run_dtors(*task_args);
}

run_dtors :: (using array: *Array(Create_And_Parameterize_Chart_Task_Args)) {
    {
        i: u32 = 0;
        while i < base.size {
            deinit(*(cast(*Create_And_Parameterize_Chart_Task_Args) base.buffer)[i]);
            i += 1;
        }
    }
}

deinit :: (using create_and_parameterize_chart_task_args: *Create_And_Parameterize_Chart_Task_Args) {
    cpp_transpiler_subobject_cleanup_g36: bool = ---;
    defer deinit(*charts);
}

index_explicit_38 :: (
    using array: *Array(Create_And_Parameterize_Chart_Task_Args),
    index: u32
) -> *Create_And_Parameterize_Chart_Task_Args {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Create_And_Parameterize_Chart_Task_Args) base.buffer)[index];
}

index_explicit_39 :: (using array: *Array(*Param_Chart), index: u32) -> **Param_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Param_Chart) base.buffer)[index];
}

deinit :: (using chart: *Param_Chart) {
    cpp_transpiler_subobject_cleanup_g37: bool = ---;
    defer deinit(*original_indices);
    cpp_transpiler_subobject_cleanup_g38: bool = ---;
    defer deinit(*face_to_source_face_map);
    cpp_transpiler_subobject_cleanup_g39: bool = ---;
    defer deinit(*vertex_to_source_vertex_map);
    cpp_transpiler_subobject_cleanup_g40: bool = ---;
    defer deinit(*chart_vertex_to_unified_vertex_map);
    cpp_transpiler_subobject_cleanup_g41: bool = ---;
    defer deinit(*backup_texcoords);
    if unified_mesh != null {
        deinit(unified_mesh);
        internal_realloc(
            cast(*void) unified_mesh,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            7245
        );
        unified_mesh = cast(*Internal_Mesh) null;
    }
}

deinit :: (using mesh: *Internal_Mesh) {
    cpp_transpiler_subobject_cleanup_g42: bool = ---;
    defer deinit(*face_ignore);
    cpp_transpiler_subobject_cleanup_g43: bool = ---;
    defer deinit(*face_materials);
    cpp_transpiler_subobject_cleanup_g44: bool = ---;
    defer deinit(*indices);
    cpp_transpiler_subobject_cleanup_g45: bool = ---;
    defer deinit(*positions);
    cpp_transpiler_subobject_cleanup_g46: bool = ---;
    defer deinit(*normals);
    cpp_transpiler_subobject_cleanup_g47: bool = ---;
    defer deinit(*texcoords);
    cpp_transpiler_subobject_cleanup_g48: bool = ---;
    defer deinit(*next_colocal_vertex);
    cpp_transpiler_subobject_cleanup_g49: bool = ---;
    defer deinit(*first_colocal_vertex);
    cpp_transpiler_subobject_cleanup_g50: bool = ---;
    defer deinit(*is_boundary_vertex);
    cpp_transpiler_subobject_cleanup_g51: bool = ---;
    defer deinit(*boundary_edges);
    cpp_transpiler_subobject_cleanup_g52: bool = ---;
    defer deinit(*opposite_edges);
    cpp_transpiler_subobject_cleanup_g53: bool = ---;
    defer deinit(*edge_map);
}

resize :: (using array: *Array(*Param_Chart), new_size: u32) {
    resize(*base, new_size, true);
}

internal_param_run_create_and_parameterize_chart_task :: (group_user_data: *void, task_user_data: *void) {
    group_args := cast(*Create_And_Parameterize_Chart_Task_Group_Args) group_user_data;
    args := cast(*Create_And_Parameterize_Chart_Task_Args) task_user_data;

    args.chart =
        (ifx true {
        cpp_transpiler_new_g54 :=
            cast(*Param_Chart) (cast(*void) (cast(*Param_Chart) internal_realloc(
                null,
                232,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                7429
            )));
        init(
            cpp_transpiler_new_g54,
            args.basis,
            args.chart_generator_type,
            args.faces,
            args.mesh,
            args.chart_group_id,
            args.chart_id
        );
        cpp_transpiler_new_g54;
    })
;

    parameterize(args.chart, group_args.options, get(group_args.boundary_grid));

    if !is_invalid(args.chart) {
        return;
    }

    invalid_chart := args.chart;
    invalid_mesh := unified_mesh_2(invalid_chart);
    pp: *Piecewise_Param = cast,no_check(*Piecewise_Param) get(group_args.pp);
    reset(pp, invalid_mesh);

    while true {
        FACES_REMAINING := compute_chart(pp);

        if !FACES_REMAINING {
            break;
        }
        chart :=
            cast(*Param_Chart) (cast(*void) (cast(*Param_Chart) internal_realloc(
                null,
                232,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                7458
            )));
        init(
            chart,
            get(group_args.chart_buffers),
            invalid_chart,
            invalid_mesh,
            chart_faces(pp),
            texcoords(pp),
            args.mesh
        );

        push_back(*args.charts, *chart);
    }

    increment(group_args.progress, args.faces.length);
}

increment :: (using progress: *Progress, _value: u32) {
    add_assign_in_xatlas(cast(*struct_atomic_base_unsigned_int) *value, _value);
    update(progress);
}

update :: (using progress: *Progress) {
    if func == null {
        return;
    }
    NEW_PERCENT :=
        cast,no_check(u32) ceilf(
            (load(
            cast(*struct_atomic_base_unsigned_int) *value,
            STD_MEMORY_ORDER_SEQ_CST
        ) / cast,no_check(float32) load(
            cast(*struct_atomic_base_unsigned_int) *max_value,
            STD_MEMORY_ORDER_SEQ_CST
        )) * 100.0
        );
    if NEW_PERCENT != operator_unsigned_int(cast(*struct_atomic_base_unsigned_int) *percent) {
        old_percent: u32 = operator_unsigned_int(cast(*struct_atomic_base_unsigned_int) *percent);
        while old_percent < NEW_PERCENT && !compare_exchange_weak(
            cast(*struct_atomic_base_unsigned_int) *percent,
            *old_percent,
            NEW_PERCENT,
            STD_MEMORY_ORDER_SEQ_CST
        ) {
        }
        if !func(
            category,
            cast,no_check(s32) operator_unsigned_int(cast(*struct_atomic_base_unsigned_int) *percent),
            user_data
        ) {
            assign_in_xatlas(*cancel, true);
        }
    }
}

assign_in_xatlas :: (using struct_atomic_bool: *struct_atomic_Bool, i: bool) -> bool {
    return assign_in_xatlas_2(*base, i);
}

assign_in_xatlas_2 :: (
    using struct_atomic_base_bool: *struct_atomic_base_Bool,
    _i: std_atomic_base_bool_int_type
) -> std_atomic_base_bool_int_type {
    store(struct_atomic_base_bool, _i, STD_MEMORY_ORDER_SEQ_CST);
    return _i;
}

store :: inline (
    using struct_atomic_base_bool: *struct_atomic_base_Bool,
    _i: std_atomic_base_bool_int_type,
    m: std_memory_order
) {
    b := std_operator(m, STD_MEMORY_ORDER_MASK);
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_ACQUIRE)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                490,
                c_string("void std::__atomic_base<bool>::store(__int_type, memory_order) [_ITp = bool]"),
                c_string("__b != memory_order_acquire")
            );
        }
        if !(false) break;
    }
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_ACQ_REL)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                491,
                c_string("void std::__atomic_base<bool>::store(__int_type, memory_order) [_ITp = bool]"),
                c_string("__b != memory_order_acq_rel")
            );
        }
        if !(false) break;
    }
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_CONSUME)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                492,
                c_string("void std::__atomic_base<bool>::store(__int_type, memory_order) [_ITp = bool]"),
                c_string("__b != memory_order_consume")
            );
        }
        if !(false) break;
    }

    c_transpiler_atomic_store(*i, _i);
}

operator_unsigned_int :: (
    using struct_atomic_base_unsigned_int_: *struct_atomic_base_unsigned_int
) -> std_atomic_base_unsigned_int_int_type {
    return load(struct_atomic_base_unsigned_int_, STD_MEMORY_ORDER_SEQ_CST);
}

load :: inline (
    using struct_atomic_base_unsigned_int_: *struct_atomic_base_unsigned_int,
    m: std_memory_order
) -> std_atomic_base_unsigned_int_int_type {
    b := std_operator(m, STD_MEMORY_ORDER_MASK);
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_RELEASE)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                515,
                c_string("__int_type std::__atomic_base<unsigned int>::load(memory_order) const [_ITp = unsigned int]"),
                c_string("__b != memory_order_release")
            );
        }
        if !(false) break;
    }
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_ACQ_REL)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                516,
                c_string("__int_type std::__atomic_base<unsigned int>::load(memory_order) const [_ITp = unsigned int]"),
                c_string("__b != memory_order_acq_rel")
            );
        }
        if !(false) break;
    }

    return atomic_load(*i);
}

compare_exchange_weak :: inline (
    using struct_atomic_base_unsigned_int_: *struct_atomic_base_unsigned_int,
    i1: *std_atomic_base_unsigned_int_int_type,
    i2: std_atomic_base_unsigned_int_int_type,
    m: std_memory_order
) -> bool {
    return compare_exchange_weak(struct_atomic_base_unsigned_int_, i1, i2, m, std_cmpexch_failure_order(m));
}

std_cmpexch_failure_order :: (m: std_memory_order) -> std_memory_order {
    return std_operator_in_xatlas(
        std_cmpexch_failure_order2(std_operator(m, STD_MEMORY_ORDER_MASK)),
        cast,no_check(std_memory_order_modifier) std_operator(m, STD_MEMORY_ORDER_MODIFIER_MASK)
    );
}

std_cmpexch_failure_order2 :: (m: std_memory_order) -> std_memory_order {
    return ifx m == STD_MEMORY_ORDER_ACQ_REL then STD_MEMORY_ORDER_ACQUIRE else (ifx m == STD_MEMORY_ORDER_RELEASE then STD_MEMORY_ORDER_RELAXED else m);
}

std_operator_in_xatlas :: (m: std_memory_order, mod: std_memory_order_modifier) -> std_memory_order {
    return (m | cast,no_check(s32) mod);
}

compare_exchange_weak :: inline (
    using struct_atomic_base_unsigned_int_: *struct_atomic_base_unsigned_int,
    i1: *std_atomic_base_unsigned_int_int_type,
    i2: std_atomic_base_unsigned_int_int_type,
    m1: std_memory_order,
    m2: std_memory_order
) -> bool {
    while true {
        if cast,no_check(s64) (!std_is_valid_cmpexch_failure_order(m2)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                551,
                c_string("bool std::__atomic_base<unsigned int>::compare_exchange_weak(__int_type &, __int_type, memory_order, memory_order) [_ITp = unsigned int]"),
                c_string("__is_valid_cmpexch_failure_order(__m2)")
            );
        }
        if !(false) break;
    }

    return c_transpiler_atomic_compare_exchange_n(*i, (cast(**std_atomic_base_unsigned_int_int_type) *(i1)).*, i2);
}

std_is_valid_cmpexch_failure_order :: (m: std_memory_order) -> bool {
    return std_operator(m, STD_MEMORY_ORDER_MASK) != STD_MEMORY_ORDER_RELEASE && std_operator(m, STD_MEMORY_ORDER_MASK) != STD_MEMORY_ORDER_ACQ_REL;
}

add_assign_in_xatlas :: (
    using struct_atomic_base_unsigned_int_: *struct_atomic_base_unsigned_int,
    _i: std_atomic_base_unsigned_int_int_type
) -> std_atomic_base_unsigned_int_int_type {
    return c_transpiler_atomic_add_fetch(*i, _i);
}

push_back :: (using array: *Array(*Param_Chart), value: **Param_Chart) {
    push_back(*base, cast(*u8) (cast(**Param_Chart) value));
}

compute_chart :: (using piecewise_param: *Piecewise_Param) -> bool {
    clear(*patch);
    clear(*candidates);
    zero_out_memory(*face_to_candidate);
    zero_out_memory(*face_invalid);
    zero_out_memory(*face_in_patch);
    zero_out_memory(*vertex_in_patch);

    FACE_COUNT := face_count(mesh);
    seed: u32 = 4294967295;
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            if get(*face_in_any_patch, f) {
                continue;
            }
            seed = f;

            _texcoords: [3] Vector2 = ---;
            {
                cpp_transpiler_fixed_array_index_g55: u64 = 0;
                while cpp_transpiler_fixed_array_index_g55 < 3 {
                    init(*_texcoords[cpp_transpiler_fixed_array_index_g55]);
                    cpp_transpiler_fixed_array_index_g55 += 1;
                }
            }
            ortho_project_face(piecewise_param, seed, _texcoords.data);
            for i_3: 0..cast(u32) 3 - 1 {
                VERTEX := vertex_at(mesh, (seed * 3) + i_3);
                set(*vertex_in_patch, VERTEX);
                assign_3(index_explicit_4(*texcoords, VERTEX), _texcoords.data + i_3);
            }
            add_face_to_patch(piecewise_param, seed);

            reset(
                *boundary_grid,
                make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2(*texcoords),
                indices(mesh),
                0
            );
            {
                it__8: Mesh_Face_Edge_Iterator = ---;
                init(*it__8, mesh, seed);
                while !is_done(*it__8) {
                    append(*boundary_grid, edge(*it__8));
                    advance(*it__8);
                }
            }
            break;
        }
    }
    if seed == 4294967295 {
        return false;
    }
    while true {
        lowest_cost: float32 = cast(float32) 3.40282347e+38;
        best_candidate: *Piecewise_Param_Candidate = cast(*Piecewise_Param_Candidate) null;
        {
            i_2: u32 = 0;
            while i_2 < size(*candidates) {
                candidate: *Piecewise_Param_Candidate =
                    cast,no_check(*Piecewise_Param_Candidate) ((cast(**Piecewise_Param_Candidate) index_explicit_40(*candidates, i_2)).*);
                if candidate.max_cost < lowest_cost {
                    lowest_cost = candidate.max_cost;
                    best_candidate = candidate;
                }
                i_2 += 1;
            }
        }
        if best_candidate == null {
            break;
        }
        assert(best_candidate.prev == null);

        position_2: Vector2 = make_vector2(0.0);
        n: u32 = 0;
        {
            it__7: Piecewise_Param_Candidate_Iterator = ---;
            init(*it__7, best_candidate);
            while !is_done(*it__7) {
                add_assign_2(*position_2, *((current(*it__7)).position));
                n += 1;
                advance(*it__7);
            }
        }
        multiply_assign(*position_2, 1.0 / cast,no_check(float32) n);
        FREE_VERTEX := best_candidate.vertex;
        assert(!internal_is_nan(position_2.x));
        assert(!internal_is_nan(position_2.y));
        assign_3(index_explicit_4(*texcoords, FREE_VERTEX), *position_2);

        invalid: bool = false;
        {
            it__6: Piecewise_Param_Candidate_Iterator = ---;
            init(*it__6, best_candidate);
            while !is_done(*it__6) {
                VERTEX0 := vertex_at(mesh, internal_mesh_edge_index0((current(*it__6)).patch_edge));
                VERTEX1 := vertex_at(mesh, internal_mesh_edge_index1((current(*it__6)).patch_edge));
                FREE_VERTEX_ORIENT :=
                    orient_to_edge(
                        piecewise_param,
                        ((cast(**Vector2) *(index_explicit_4(*texcoords, VERTEX0))).*).*,
                        ((cast(**Vector2) *(index_explicit_4(*texcoords, VERTEX1))).*).*,
                        position_2
                    );
                if (current(*it__6)).patch_vertex_orient < 0.0 && FREE_VERTEX_ORIENT < 0.0 ||
                    (current(*it__6)).patch_vertex_orient > 0.0 && FREE_VERTEX_ORIENT > 0.0 {
                    invalid = true;
                    break;
                }
                advance(*it__6);
            }
        }

        {
            it__5: Piecewise_Param_Candidate_Iterator = ---;
            init(*it__5, best_candidate);
            while !is_done(*it__5) {
                A :=
                    ((cast(**Vector2) *(index_explicit_4(*texcoords, vertex_at(mesh, ((current(*it__5)).face * 3) +
                        0)))).*).*;
                B :=
                    ((cast(**Vector2) *(index_explicit_4(*texcoords, vertex_at(mesh, ((current(*it__5)).face * 3) +
                        1)))).*).*;
                C :=
                    ((cast(**Vector2) *(index_explicit_4(*texcoords, vertex_at(mesh, ((current(*it__5)).face * 3) +
                        2)))).*).*;
                AREA := internal_triangle_area(*A, *B, *C);
                if AREA <= 0.0 {
                    invalid = true;
                    break;
                }
                advance(*it__5);
            }
        }

        if !invalid {
            clear(*new_boundary_edges);
            clear(*ignore_boundary_edges);
            {
                candidate_it: Piecewise_Param_Candidate_Iterator = ---;
                init(*candidate_it, best_candidate);
                while !is_done(*candidate_it) {
                    {
                        it__4: Mesh_Face_Edge_Iterator = ---;
                        init(*it__4, mesh, (current(*candidate_it)).face);
                        while !is_done(*it__4) {
                            OFACE_2 := opposite_face(*it__4);
                            if OFACE_2 == 4294967295 || !get(*face_in_patch, OFACE_2) {
                                push_back(
                                    *new_boundary_edges,
                                    (ifx true { temporary___g0: u32 = edge(*it__4); *temporary___g0; })
                                );
                            }
                            if OFACE_2 != 4294967295 && get(*face_in_patch, OFACE_2) {
                                push_back(
                                    *ignore_boundary_edges,
                                    (ifx true { temporary___g1: u32 = opposite_edge(*it__4); *temporary___g1; })
                                );
                            }
                            advance(*it__4);
                        }
                    }
                    advance(*candidate_it);
                }
            }
            (ifx true { assignment_32: bool = cast,no_check(bool) (intersect(
                *boundary_grid,
                epsilon(mesh),
                make_struct_xatlas_internal_const_array_view_unsigned_int(*new_boundary_edges),
                make_struct_xatlas_internal_const_array_view_unsigned_int(*ignore_boundary_edges)
            )); (invalid) = assignment_32; assignment_32; });
        }
        if invalid {
            {
                it__3: Piecewise_Param_Candidate_Iterator = ---;
                init(*it__3, best_candidate);
                while !is_done(*it__3) {
                    set(*face_invalid, (current(*it__3)).face);
                    advance(*it__3);
                }
            }
            remove_linked_candidates(piecewise_param, best_candidate);
        } else {
            set(*vertex_in_patch, FREE_VERTEX);

            {
                it__2: Piecewise_Param_Candidate_Iterator = ---;
                init(*it__2, best_candidate);
                while !is_done(*it__2) {
                    add_face_to_patch(piecewise_param, (current(*it__2)).face);
                    advance(*it__2);
                }
            }

            remove_linked_candidates(piecewise_param, best_candidate);

            reset(
                *boundary_grid,
                make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2(*texcoords),
                indices(mesh),
                0
            );
            {
                i: u32 = 0;
                while i < size(*patch) {
                    {
                        it_: Mesh_Face_Edge_Iterator = ---;
                        init(*it_, mesh, ((cast(**u32) *(index_explicit(*patch, i))).*).*);
                        while !is_done(*it_) {
                            OFACE := opposite_face(*it_);
                            if OFACE == 4294967295 || !get(*face_in_patch, OFACE) {
                                append(*boundary_grid, edge(*it_));
                            }
                            advance(*it_);
                        }
                    }
                    i += 1;
                }
            }
        }
    }
    return true;
}

edge :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> u32 {
    return edge;
}

opposite_face :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> u32 {
    OEDGE: u32 = ((cast(**u32) *(index_explicit_7(*mesh.opposite_edges, edge))).*).*;
    if OEDGE == 4294967295 {
        return 4294967295;
    }
    return internal_mesh_edge_face(OEDGE);
}

internal_mesh_edge_face :: (edge_2: u32) -> u32 {
    return edge_2 / 3;
}

advance :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) {
    if relative_edge < 3 {
        edge += 1;
        relative_edge += 1;
    }
}

is_done :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> bool {
    return relative_edge == 3;
}

remove_linked_candidates :: (using piecewise_param: *Piecewise_Param, head: *Piecewise_Param_Candidate) {
    assert(head.prev == null);
    current_2 := head;
    while current_2 != null {
        next: *Piecewise_Param_Candidate = cast,no_check(*Piecewise_Param_Candidate) current_2.next;
        (cast(**Piecewise_Param_Candidate) index_explicit_40(*face_to_candidate, current_2.face)).* =
            cast(*Piecewise_Param_Candidate) null;
        {
            i: u32 = 0;
            while i < size(*candidates) {
                if (cast(**Piecewise_Param_Candidate) index_explicit_40(*candidates, i)).* == current_2 {
                    remove_at(*candidates, i);
                    break;
                }
                i += 1;
            }
        }
        internal_realloc(
            cast(*void) current_2,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            6916
        );
        current_2 = next;
    }
}

remove_at :: (using array: *Array(*Piecewise_Param_Candidate), index: u32) {
    remove_at(*base, index);
}

remove_at :: (using array_base: *Array_Base, index: u32) {
    assert(index >= 0 && index < size);
    assert(buffer != null);
    if buffer != null {
        if size > 1 {
            move_memory(
                buffer + element_size * index,
                buffer + element_size * (index + 1),
                cast,no_check(u64) (element_size * ((size - 1) - index))
            );
        }
        if size > 0 {
            size -= 1;
        }
    }
}

index_explicit_40 :: (using array: *Array(*Piecewise_Param_Candidate), index: u32) -> **Piecewise_Param_Candidate {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Piecewise_Param_Candidate) base.buffer)[index];
}

size :: (using array: *Array(*Piecewise_Param_Candidate)) -> u32 {
    return base.size;
}

add_face_to_patch :: (using piecewise_param: *Piecewise_Param, face_2: u32) {
    assert(!get(*face_in_patch, face_2));
    assert(!get(*face_in_any_patch, face_2));
    push_back(*patch, *face_2);
    set(*face_in_patch, face_2);
    set(*face_in_any_patch, face_2);

    {
        it_: Mesh_Face_Edge_Iterator = ---;
        init(*it_, mesh, face_2);
        while !is_done(*it_) {
            OFACE := opposite_face(*it_);
            if OFACE == 4294967295 ||
                get(*face_in_any_patch, OFACE) ||
                (((cast(**Piecewise_Param_Candidate) index_explicit_40(*face_to_candidate, OFACE)).*) != null) {
                advance(*it_);
                continue;
            }

            free_vertex: u32 = 4294967295;
            orient: float32 = 0.0;
            for j: 0..cast(u32) 3 - 1 {
                VERTEX := vertex_at(mesh, (OFACE * 3) + j);
                if VERTEX != vertex0(*it_) && VERTEX != vertex1(*it_) {
                    free_vertex = VERTEX;
                    orient =
                        orient_to_edge(
                            piecewise_param,
                            ((cast(**Vector2) *(index_explicit_4(*texcoords, vertex0(*it_)))).*).*,
                            ((cast(**Vector2) *(index_explicit_4(*texcoords, vertex1(*it_)))).*).*,
                            ((cast(**Vector2) *(index_explicit_4(*texcoords, vertex_at(mesh, (face_2 * 3) + j)))).*).*
                        );
                    break;
                }
            }
            assert(free_vertex != 4294967295);
            if get(*vertex_in_patch, free_vertex) {
                advance(*it_);
                continue;
            }

            if get(*face_invalid, OFACE) {
                advance(*it_);
                continue;
            }
            add_candidate_face(piecewise_param, edge(*it_), orient, OFACE, opposite_edge(*it_), free_vertex);
            advance(*it_);
        }
    }
}

opposite_edge :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*mesh.opposite_edges, edge))).*).*;
}

add_candidate_face :: (
    using piecewise_param: *Piecewise_Param,
    patch_edge: u32,
    patch_vertex_orient: float32,
    face_2: u32,
    edge_2: u32,
    free_vertex: u32
) {
    assert((cast(**Piecewise_Param_Candidate) index_explicit_40(*face_to_candidate, face_2)).* == null);
    _texcoords: [3] Vector2 = ---;
    {
        cpp_transpiler_fixed_array_index_g56: u64 = 0;
        while cpp_transpiler_fixed_array_index_g56 < 3 {
            init(*_texcoords[cpp_transpiler_fixed_array_index_g56]);
            cpp_transpiler_fixed_array_index_g56 += 1;
        }
    }
    ortho_project_face(piecewise_param, face_2, _texcoords.data);

    VERTEX0 := vertex_at(mesh, internal_mesh_edge_index0(patch_edge));
    VERTEX1 := vertex_at(mesh, internal_mesh_edge_index1(patch_edge));
    local_vertex0: u32 = 4294967295;
    local_vertex1: u32 = 4294967295;
    local_free_vertex: u32 = 4294967295;
    for i_5: 0..cast(u32) 3 - 1 {
        VERTEX := vertex_at(mesh, (face_2 * 3) + i_5);
        if VERTEX == vertex_at(mesh, internal_mesh_edge_index1(edge_2)) {
            local_vertex0 = i_5;
        } else if VERTEX == vertex_at(mesh, internal_mesh_edge_index0(edge_2)) {
            local_vertex1 = i_5;
        } else {
            local_free_vertex = i_5;
        }
    }

    PATCH_EDGE_VEC :=
        internal_operator(
            index_explicit_4(*texcoords, VERTEX1),
            index_explicit_4(*texcoords, VERTEX0)
        );
    LOCAL_EDGE_VEC := internal_operator(_texcoords.data + local_vertex1, _texcoords.data + local_vertex0);
    LEN1 := internal_length(*PATCH_EDGE_VEC);
    LEN2 := internal_length(*LOCAL_EDGE_VEC);
    if LEN1 <= 0.0 || LEN2 <= 0.0 {
        return;
    }
    SCALE := LEN1 / LEN2;
    for i_4: 0..cast(u32) 3 - 1 {
        multiply_assign(_texcoords.data + i_4, SCALE);
    }

    TRANSLATE := internal_operator(index_explicit_4(*texcoords, VERTEX0), _texcoords.data + local_vertex0);
    for i_3: 0..cast(u32) 3 - 1 {
        add_assign_2(_texcoords.data + i_3, *TRANSLATE);
    }

    ANGLE := atan2f(PATCH_EDGE_VEC.y, PATCH_EDGE_VEC.x) - atan2f(LOCAL_EDGE_VEC.y, LOCAL_EDGE_VEC.x);

    for i_2: 0..cast(u32) 3 - 1 {
        if i_2 == local_vertex0 {
            continue;
        }
        uv := _texcoords.data + i_2;
        subtract_assign(uv, _texcoords.data + local_vertex0);
        C := cosf(ANGLE);
        S := sinf(ANGLE);
        X := uv.x * C - uv.y * S;
        Y := uv.y * C + uv.x * S;
        uv.x = X + _texcoords[local_vertex0].x;
        uv.y = Y + _texcoords[local_vertex0].y;
    }
    if internal_is_nan(_texcoords[local_free_vertex].x) || internal_is_nan(_texcoords[local_free_vertex].y) {
        set(*face_invalid, face_2);
        return;
    }

    FREE_VERTEX_ORIENT :=
        orient_to_edge(
            piecewise_param,
            ((cast(**Vector2) *(index_explicit_4(*texcoords, VERTEX0))).*).*,
            ((cast(**Vector2) *(index_explicit_4(*texcoords, VERTEX1))).*).*,
            _texcoords[local_free_vertex]
        );
    if patch_vertex_orient < 0.0 && FREE_VERTEX_ORIENT < 0.0 || patch_vertex_orient > 0.0 && FREE_VERTEX_ORIENT > 0.0 {
        set(*face_invalid, face_2);
        return;
    }
    STRETCH :=
        compute_stretch(
            piecewise_param,
            ((cast(**Vector3) *(position(mesh, VERTEX0))).*).*,
            ((cast(**Vector3) *(position(mesh, VERTEX1))).*).*,
            ((cast(**Vector3) *(position(mesh, free_vertex))).*).*,
            _texcoords[0],
            _texcoords[1],
            _texcoords[2]
        );
    if STRETCH >= cast(float32) 3.40282347e+38 {
        set(*face_invalid, face_2);
        return;
    }
    COST := fabsf(STRETCH - 1.0);
    if COST > 0.5 {
        set(*face_invalid, face_2);
        return;
    }

    candidate :=
        cast(*Piecewise_Param_Candidate) internal_realloc(
            null,
            48,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            6857
        );
    candidate.face = face_2;
    candidate.vertex = free_vertex;
    assign_3(*candidate.position, _texcoords.data + local_free_vertex);
    candidate.next = cast(*Piecewise_Param_Candidate) null;
    candidate.prev = candidate.next;
    candidate.max_cost = COST;
    candidate.cost = candidate.max_cost;
    candidate.patch_edge = patch_edge;
    candidate.patch_vertex_orient = patch_vertex_orient;
    push_back(*candidates, *candidate);
    assignment_33: *Piecewise_Param_Candidate = cast,no_check(*Piecewise_Param_Candidate) candidate;
    ((cast(**Piecewise_Param_Candidate) index_explicit_40(*face_to_candidate, face_2)).*) = assignment_33;

    {
        i: u32 = 0;
        while i < size(*candidates) - 1 {
            if ((cast(**Piecewise_Param_Candidate) index_explicit_40(*candidates, i)).*).vertex == candidate.vertex {
                tail: *Piecewise_Param_Candidate =
                    cast,no_check(*Piecewise_Param_Candidate) ((cast(**Piecewise_Param_Candidate) index_explicit_40(*candidates, i)).*);
                while true {
                    if tail.next != null {
                        tail = cast,no_check(*Piecewise_Param_Candidate) tail.next;
                    } else {
                        break;
                    }
                }
                candidate.prev = cast,no_check(*Piecewise_Param_Candidate) tail;
                candidate.next = cast(*Piecewise_Param_Candidate) null;
                tail.next = cast,no_check(*Piecewise_Param_Candidate) candidate;
                break;
            }
            i += 1;
        }
    }

    head := linked_candidate_head(piecewise_param, candidate);
    max_cost: float32 = 0.0;
    {
        it__2: Piecewise_Param_Candidate_Iterator = ---;
        init(*it__2, head);
        while !is_done(*it__2) {
            max_cost = internal_max(*max_cost, *((current(*it__2)).cost));
            advance(*it__2);
        }
    }
    {
        it_: Piecewise_Param_Candidate_Iterator = ---;
        init(*it_, head);
        while !is_done(*it_) {
            assignment_34: float32 = max_cost;
            ((current(*it_)).max_cost) = assignment_34;
            advance(*it_);
        }
    }
}

advance :: (using candidate_iterator: *Piecewise_Param_Candidate_Iterator) {
    if current != null {
        current = cast,no_check(*Piecewise_Param_Candidate) current.next;
    }
}

is_done :: (using candidate_iterator: *Piecewise_Param_Candidate_Iterator) -> bool {
    return current == null;
}

push_back :: (using array: *Array(*Piecewise_Param_Candidate), value: **Piecewise_Param_Candidate) {
    push_back(*base, cast(*u8) (cast(**Piecewise_Param_Candidate) value));
}

compute_stretch :: (
    using piecewise_param: *Piecewise_Param,
    p1: Vector3,
    p2: Vector3,
    p3: Vector3,
    t1: Vector2,
    t2: Vector2,
    t3: Vector2
) -> float32 {
    local_p1: Vector3 = p1;
    local_p2: Vector3 = p2;
    local_p3: Vector3 = p3;
    parametric_area_2 := ((t2.y - t1.y) * (t3.x - t1.x) - (t3.y - t1.y) * (t2.x - t1.x)) * 0.5;
    if internal_is_zero(parametric_area_2, K_AREA_EPSILON) {
        return cast(float32) 3.40282347e+38;
    }
    if parametric_area_2 < 0.0 {
        parametric_area_2 = fabsf(parametric_area_2);
    }
    GEOMETRIC_AREA :=
        internal_length(
            (ifx true { temporary___g2: Vector3 = internal_cross(
            (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(*local_p2, *local_p1); *temporary___g0; }),
            (ifx true { temporary___g1: Vector3 = internal_operator_in_xatlas_2(*local_p3, *local_p1); *temporary___g1; })
        ); *temporary___g2; })
        ) * 0.5;
    if parametric_area_2 <= GEOMETRIC_AREA {
        return parametric_area_2 / GEOMETRIC_AREA;
    } else {
        return GEOMETRIC_AREA / parametric_area_2;
    }
}

internal_is_zero :: (F: float32, EPSILON: float32) -> bool {
    return std_fabs(F) <= EPSILON;
}

orient_to_edge :: (
    using piecewise_param: *Piecewise_Param,
    edge_vertex0: Vector2,
    edge_vertex1: Vector2,
    point: Vector2
) -> float32 {
    return (edge_vertex0.x - point.x) * (edge_vertex1.y - point.y) - (edge_vertex0.y - point.y) * (edge_vertex1.x - point.x);
}

add_assign_2 :: (using vector2: *Vector2, v: *Vector2) {
    x += v.x;
    y += v.y;
}

ortho_project_face :: (using piecewise_param: *Piecewise_Param, face_2: u32, _texcoords: *Vector2) {
    NORMAL: Vector3 =
        subtract(
            (ifx true { temporary___g0: Vector3 = compute_face_normal(mesh, face_2); *temporary___g0; })
        );
    TANGENT :=
        internal_normalize(
            (ifx true { temporary___g1: Vector3 = internal_operator_in_xatlas_2(
            position(mesh, vertex_at(mesh, (face_2 * 3) + 1)),
            position(mesh, vertex_at(mesh, (face_2 * 3) + 0))
        ); *temporary___g1; })
        );
    BITANGENT := internal_cross(*NORMAL, *TANGENT);
    for i: 0..cast(u32) 3 - 1 {
        pos: *Vector3 = cast,no_check(*Vector3) position(mesh, vertex_at(mesh, (face_2 * 3) + i));
        assign(
            *_texcoords[i],
            (ifx true { temporary___g2: Vector2 = make_vector2(internal_dot(*TANGENT, pos), internal_dot(*BITANGENT, pos)); *temporary___g2; })
        );
    }
}

internal_dot :: (a: *Vector3, b: *Vector3) -> float32 {
    return a.x * b.x + a.y * b.y + a.z * b.z;
}

vertex1 :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*mesh.indices, (face * 3) + (relative_edge + 1) % 3))).*).*;
}

vertex0 :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*mesh.indices, (face * 3) + relative_edge))).*).*;
}

epsilon :: (using mesh: *Internal_Mesh) -> float32 {
    return epsilon;
}

intersect :: (
    using uniform_grid2: *Uniform_Grid2,
    epsilon_2: float32,
    _edges: Const_Array_View(u32),
    ignore_edges: Const_Array_View(u32)
) -> bool {
    local_ignore_edges: Const_Array_View(u32) = ignore_edges;
    brute_force := size(*edges) <= 20;
    if !brute_force && is_empty(*cell_data_offsets) {
        brute_force = cast,no_check(bool) (!create_grid(uniform_grid2));
    }
    edges1: *u32 = ---;
    edges2: *u32 = cast(*u32) null;
    edges1_count: u32 = ---;
    edges2_count: u32 = 0;
    if _edges.length == 0 {
        edges1 = data(*edges);
        edges1_count = size(*edges);
    } else {
        edges1 = cast,no_check(*u32) _edges.data;
        edges1_count = _edges.length;
    }
    if brute_force {
        edges2 = data(*edges);
        edges2_count = size(*edges);
    }
    if 0 < edges1_count {
        for i: 0..edges1_count - 1 {
            EDGE1 := edges1[i];
            EDGE1_VERTEX :=
                u32.[ vertex_at(uniform_grid2, internal_mesh_edge_index0(EDGE1)), vertex_at(uniform_grid2, internal_mesh_edge_index1(EDGE1)) ];
            edge1_position1: *Vector2 = cast,no_check(*Vector2) index_explicit_13(*positions, EDGE1_VERTEX[0]);
            edge1_position2: *Vector2 = cast,no_check(*Vector2) index_explicit_13(*positions, EDGE1_VERTEX[1]);
            EDGE1_EXTENTS: Extents2 = ---;
            init(*EDGE1_EXTENTS, edge1_position1.*, edge1_position2.*);
            j: u32 = 0;
            if brute_force {
                if _edges.length == 0 {
                    j = i + 1;
                    if j == edges1_count {
                        break;
                    }
                }
            } else {
                compute_potential_edges(
                    uniform_grid2,
                    edge_position0(uniform_grid2, EDGE1),
                    edge_position1(uniform_grid2, EDGE1)
                );
                edges2 = data(*potential_edges);
                edges2_count = size(*potential_edges);
            }
            prev_edge: u32 = 4294967295;
            while j < edges2_count {
                EDGE2 := edges2[j];
                if EDGE1 == EDGE2 {
                    j += 1;
                    continue;
                }
                if EDGE2 == prev_edge {
                    j += 1;
                    continue;
                }
                prev_edge = EDGE2;

                ignore: bool = false;
                {
                    k: u32 = 0;
                    while k < local_ignore_edges.length {
                        if EDGE2 == ((cast(**u32) *(index_explicit_12(*local_ignore_edges, k))).*).* {
                            ignore = true;
                            break;
                        }
                        k += 1;
                    }
                }
                if ignore {
                    j += 1;
                    continue;
                }
                EDGE2_VERTEX :=
                    u32.[ vertex_at(uniform_grid2, internal_mesh_edge_index0(EDGE2)), vertex_at(uniform_grid2, internal_mesh_edge_index1(EDGE2)) ];

                if EDGE1_VERTEX[0] == EDGE2_VERTEX[0] ||
                    EDGE1_VERTEX[0] == EDGE2_VERTEX[1] ||
                    EDGE1_VERTEX[1] == EDGE2_VERTEX[0] ||
                    EDGE1_VERTEX[1] == EDGE2_VERTEX[1] {
                    j += 1;
                    continue;
                }
                edge2_position1: *Vector2 = cast,no_check(*Vector2) index_explicit_13(*positions, EDGE2_VERTEX[0]);
                edge2_position2: *Vector2 = cast,no_check(*Vector2) index_explicit_13(*positions, EDGE2_VERTEX[1]);
                if !intersect(
                    *EDGE1_EXTENTS,
                    (ifx true { temporary___g0: Extents2 = (ifx true {
    temporary_g57: Extents2 = ---;
    init(*temporary_g57, edge2_position1.*, edge2_position2.*);
    temporary_g57;
})
; *temporary___g0; })
                ) {
                    j += 1;
                    continue;
                }
                if internal_lines_intersect(edge1_position1, edge1_position2, edge2_position1, edge2_position2, epsilon_2) {
                    return true;
                }
                j += 1;
            }
        }
    }
    return false;
}

intersect :: (e1: *Extents2, e2: *Extents2) -> bool {
    return e1.min.x <= e2.max.x && e1.max.x >= e2.min.x && e1.min.y <= e2.max.y && e1.max.y >= e2.min.y;
}

zero_out_memory :: (using array: *Array(*Piecewise_Param_Candidate)) {
    if base.buffer != null && base.size > 0 {
        fill_memory(base.buffer, 0, cast,no_check(u64) (base.element_size * base.size));
    }
}

clear :: (using array: *Array(*Piecewise_Param_Candidate)) {
    clear(*base);
}

get :: (using thread_local: *Thread_Local(Piecewise_Param)) -> *Piecewise_Param {
    return *array[current_thread_index()];
}

reset :: (using piecewise_param: *Piecewise_Param, _mesh: *Internal_Mesh) {
    mesh = _mesh;
    FACE_COUNT := face_count(mesh);
    VERTEX_COUNT := vertex_count(mesh);
    resize(*texcoords, VERTEX_COUNT);
    reserve(*patch, FACE_COUNT);
    reserve(*candidates, FACE_COUNT);
    resize(*face_in_any_patch, FACE_COUNT);
    zero_out_memory(*face_in_any_patch);
    resize(*face_invalid, FACE_COUNT);
    resize(*face_in_patch, FACE_COUNT);
    resize(*vertex_in_patch, VERTEX_COUNT);
    resize(*face_to_candidate, FACE_COUNT);
}

resize :: (using array: *Array(*Piecewise_Param_Candidate), new_size: u32) {
    resize(*base, new_size, true);
}

reserve :: (using array: *Array(*Piecewise_Param_Candidate), desired_size: u32) {
    reserve(*base, desired_size);
}

get :: (using thread_local: *Thread_Local(Uniform_Grid2)) -> *Uniform_Grid2 {
    return *array[current_thread_index()];
}

parameterize :: (chart: *Param_Chart, options_: *Chart_Options, boundary_grid: *Uniform_Grid2) {
    UNIFIED_VERTEX_COUNT := vertex_count(chart.unified_mesh);
    if !(cast,no_check(s32) chart.generator_type == cast(s32) INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_ORIGINAL_UV) {
        if 0 < UNIFIED_VERTEX_COUNT {
            for i_2: 0..UNIFIED_VERTEX_COUNT - 1 {
                assign(
                    texcoord(chart.unified_mesh, i_2),
                    (ifx true { temporary___g0: Vector2 = make_vector2(
                    internal_dot(*chart.basis.tangent, position(chart.unified_mesh, i_2)),
                    internal_dot(*chart.basis.bitangent, position(chart.unified_mesh, i_2))
                ); *temporary___g0; })
                );
            }
        }

        if chart.type != CHART_TYPE_PLANAR &&
            cast,no_check(s32) chart.generator_type != cast(s32) INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_ORIGINAL_UV {
            compute_boundary_intersection(*chart.quality, chart.unified_mesh, boundary_grid);
            compute_flipped_faces(*chart.quality, chart.unified_mesh, cast(*Array(u32)) null);
            compute_metrics(*chart.quality, chart.unified_mesh);

            if !chart.quality.boundary_intersection &&
                chart.quality.flipped_triangle_count == 0 &&
                chart.quality.zero_area_triangle_count == 0 &&
                chart.quality.total_geometric_area > 0.0 &&
                chart.quality.stretch_metric <= 1.1 &&
                chart.quality.max_stretch_metric <= 1.25 {
                chart.type = CHART_TYPE_ORTHO;
            }
        }
        if chart.type == CHART_TYPE_LSCM {
            if options_.param_func != null {
                options_.param_func(
                    *((position(chart.unified_mesh, 0)).x),
                    *((texcoord(chart.unified_mesh, 0)).x),
                    vertex_count(chart.unified_mesh),
                    (indices(chart.unified_mesh)).data,
                    index_count(chart.unified_mesh)
                );
            } else {
                internal_param_compute_least_squares_conformal_map(chart.unified_mesh);
            }

            compute_boundary_intersection(*chart.quality, chart.unified_mesh, boundary_grid);

            compute_flipped_faces(*chart.quality, chart.unified_mesh, cast(*Array(u32)) null);

            if chart.quality.boundary_intersection ||
                chart.quality.flipped_triangle_count > 0 ||
                chart.quality.zero_area_triangle_count > 0 {
                chart.is_invalid = true;
            }
        }
    }
    if options_.fix_winding && compute_face_parametric_area(chart.unified_mesh, 0) < 0.0 {
        if 0 < UNIFIED_VERTEX_COUNT {
            for i: 0..UNIFIED_VERTEX_COUNT - 1 {
                c_transpiler_compound_mul(*((texcoord(chart.unified_mesh, i)).x), (-1.0), float32, float32);
            }
        }
    }

    backup_texcoords(chart);
}

backup_texcoords :: (using chart: *Param_Chart) {
    resize(*backup_texcoords, vertex_count(unified_mesh));
    copy_memory(data_2(*backup_texcoords), (texcoords(unified_mesh)).data, (cast(u64) vertex_count(unified_mesh)) * 8);
}

compute_flipped_faces :: (using quality_2: *Quality, mesh: *Internal_Mesh, flipped_faces: *Array(u32)) {
    zero_area_triangle_count = 0;
    flipped_triangle_count = zero_area_triangle_count;
    total_triangle_count = flipped_triangle_count;
    if flipped_faces != null {
        clear(flipped_faces);
    }
    FACE_COUNT := face_count(mesh);
    {
        f_2: u32 = 0;
        while f_2 < FACE_COUNT {
            texcoord_3: [3] Vector2 = ---;
            {
                cpp_transpiler_fixed_array_index_g58: u64 = 0;
                while cpp_transpiler_fixed_array_index_g58 < 3 {
                    init(*texcoord_3[cpp_transpiler_fixed_array_index_g58]);
                    cpp_transpiler_fixed_array_index_g58 += 1;
                }
            }
            for i: 0..cast(s32) 3 - 1 {
                V := vertex_at(mesh, (f_2 * 3) + cast,no_check(u32) i);
                assign_3(texcoord_3.data + i, texcoord_2(mesh, V));
            }
            total_triangle_count += 1;
            T1 := texcoord_3[0].x;
            S1 := texcoord_3[0].y;
            T2 := texcoord_3[1].x;
            S2 := texcoord_3[1].y;
            T3 := texcoord_3[2].x;
            S3 := texcoord_3[2].y;
            PARAMETRIC_AREA := ((S2 - S1) * (T3 - T1) - (S3 - S1) * (T2 - T1)) * 0.5;
            if internal_is_zero(PARAMETRIC_AREA, K_AREA_EPSILON) {
                zero_area_triangle_count += 1;
                f_2 += 1;
                continue;
            }
            if PARAMETRIC_AREA < 0.0 {
                flipped_triangle_count += 1;
                if flipped_faces != null {
                    push_back(flipped_faces, *f_2);
                }
            }
            f_2 += 1;
        }
    }
    if flipped_triangle_count + zero_area_triangle_count == total_triangle_count {
        if flipped_faces != null {
            clear(flipped_faces);
        }
        flipped_triangle_count = 0;
    }
    if flipped_triangle_count > total_triangle_count / 2 {
        flipped_triangle_count = total_triangle_count - flipped_triangle_count;
        if flipped_faces != null {
            temp: Array(u32) = ---;
            defer deinit(*temp);
            init(*temp, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
            copy_to(flipped_faces, *temp);
            clear(flipped_faces);
            {
                f: u32 = 0;
                while f < FACE_COUNT {
                    match: bool = false;
                    {
                        ff: u32 = 0;
                        while ff < size(*temp) {
                            if ((cast(**u32) *(index_explicit(*temp, ff))).*).* == f {
                                match = true;
                                break;
                            }
                            ff += 1;
                        }
                    }
                    if !match {
                        push_back(flipped_faces, *f);
                    }
                    f += 1;
                }
            }
        }
    }
}

copy_to :: (using array: *Array(u32), other: *Array(u32)) {
    copy_to(*base, *other.base);
}

compute_boundary_intersection :: (using quality_2: *Quality, mesh: *Internal_Mesh, boundary_grid: *Uniform_Grid2) {
    boundary_edges_2: *Array(u32) = cast,no_check(*Array(u32)) boundary_edges(mesh);
    BOUNDARY_EDGE_COUNT := size(boundary_edges_2);
    reset(boundary_grid, texcoords_2(mesh), indices(mesh), BOUNDARY_EDGE_COUNT);
    if 0 < BOUNDARY_EDGE_COUNT {
        for i: 0..BOUNDARY_EDGE_COUNT - 1 {
            append(boundary_grid, ((cast(**u32) *(index_explicit_7(boundary_edges_2, i))).*).*);
        }
    }
    (ifx true { assignment_35: bool = cast,no_check(bool) (intersect(boundary_grid, epsilon(mesh), Const_Array_View(u32).{}, Const_Array_View(u32).{})); (boundary_intersection) = assignment_35; assignment_35; });
}

texcoords_2 :: (using mesh: *Internal_Mesh) -> Const_Array_View(Vector2) {
    return make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2(*texcoords);
}

internal_param_compute_least_squares_conformal_map :: (mesh: *Internal_Mesh) -> bool {
    locked_vertex0, locked_vertex1: u32 = ---;
    if !internal_param_find_approximate_diameter_vertices(mesh, *locked_vertex0, *locked_vertex1) {
        return false;
    }
    VERTEX_COUNT := vertex_count(mesh);
    context_: *NL_Context = cast,no_check(*NL_Context) internal_opennl_nl_new_context();
    internal_opennl_nl_solver_parameteri(context_, 0x101, cast,no_check(s32) (2 * VERTEX_COUNT));
    internal_opennl_nl_solver_parameteri(context_, 0x103, cast,no_check(s32) (5 * VERTEX_COUNT));
    internal_opennl_nl_begin(context_, 0);
    texcoords_3 := texcoords(mesh);
    if 0 < VERTEX_COUNT {
        for i_2: 0..VERTEX_COUNT - 1 {
            internal_opennl_nl_set_variable(
                context_,
                2 * i_2,
                cast,no_check(float64) ((index_explicit_2(*texcoords_3, i_2)).x)
            );
            internal_opennl_nl_set_variable(
                context_,
                2 * i_2 + 1,
                cast,no_check(float64) ((index_explicit_2(*texcoords_3, i_2)).y)
            );
            if i_2 == locked_vertex0 || i_2 == locked_vertex1 {
                internal_opennl_nl_lock_variable(context_, 2 * i_2);
                internal_opennl_nl_lock_variable(context_, 2 * i_2 + 1);
            }
        }
    }
    internal_opennl_nl_begin(context_, 0x1);
    FACE_COUNT := face_count(mesh);
    positions_2 := positions(mesh);
    indices_2 := indices(mesh);
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            V0: u32 = ((cast(**u32) *(index_explicit_12(*indices_2, (f * 3) + 0))).*).*;
            V1: u32 = ((cast(**u32) *(index_explicit_12(*indices_2, (f * 3) + 1))).*).*;
            V2: u32 = ((cast(**u32) *(index_explicit_12(*indices_2, (f * 3) + 2))).*).*;
            if !internal_param_setup_abf_relations(
                context_,
                cast,no_check(s32) V0,
                cast,no_check(s32) V1,
                cast,no_check(s32) V2,
                index_explicit_14(*positions_2, V0),
                index_explicit_14(*positions_2, V1),
                index_explicit_14(*positions_2, V2)
            ) {
                z0: Vector2 = ---;
                init(*z0);
                z1: Vector2 = ---;
                init(*z1);
                z2: Vector2 = ---;
                init(*z2);
                internal_param_project_triangle(
                    ((cast(**Vector3) *(index_explicit_14(*positions_2, V0))).*).*,
                    ((cast(**Vector3) *(index_explicit_14(*positions_2, V1))).*).*,
                    ((cast(**Vector3) *(index_explicit_14(*positions_2, V2))).*).*,
                    *z0,
                    *z1,
                    *z2
                );
                a := cast,no_check(float64) (z1.x - z0.x);
                b := cast,no_check(float64) (z1.y - z0.y);
                c_ := cast,no_check(float64) (z2.x - z0.x);
                d := cast,no_check(float64) (z2.y - z0.y);
                assert(b == 0.0);

                u0_id := 2 * V0;
                v0_id := 2 * V0 + 1;
                u1_id := 2 * V1;
                v1_id := 2 * V1 + 1;
                u2_id := 2 * V2;
                v2_id := 2 * V2 + 1;

                internal_opennl_nl_begin(context_, 0x2);
                internal_opennl_nl_coefficient(context_, u0_id, -a + c_);
                internal_opennl_nl_coefficient(context_, v0_id, b - d);
                internal_opennl_nl_coefficient(context_, u1_id, -c_);
                internal_opennl_nl_coefficient(context_, v1_id, d);
                internal_opennl_nl_coefficient(context_, u2_id, a);
                internal_opennl_nl_end(context_, 0x2);

                internal_opennl_nl_begin(context_, 0x2);
                internal_opennl_nl_coefficient(context_, u0_id, -b + d);
                internal_opennl_nl_coefficient(context_, v0_id, -a + c_);
                internal_opennl_nl_coefficient(context_, u1_id, -d);
                internal_opennl_nl_coefficient(context_, v1_id, -c_);
                internal_opennl_nl_coefficient(context_, v2_id, a);
                internal_opennl_nl_end(context_, 0x2);
            }
        }
    }
    internal_opennl_nl_end(context_, 0x1);
    internal_opennl_nl_end(context_, 0);
    if !internal_opennl_nl_solve(context_) {
        internal_opennl_nl_delete_context(context_);
        return false;
    }
    if 0 < VERTEX_COUNT {
        for i: 0..VERTEX_COUNT - 1 {
            U := internal_opennl_nl_get_variable(context_, 2 * i);
            V := internal_opennl_nl_get_variable(context_, 2 * i + 1);
            assign(
                index_explicit_2(*texcoords_3, i),
                (ifx true { temporary___g0: Vector2 = make_vector2(cast,no_check(float32) U, cast,no_check(float32) V); *temporary___g0; })
            );
            assert(!internal_is_nan((texcoord(mesh, i)).x));
            assert(!internal_is_nan((texcoord(mesh, i)).y));
        }
    }
    internal_opennl_nl_delete_context(context_);
    return true;
}

internal_opennl_nl_new_context :: () -> *NL_Context {
    result :=
        cast(*NL_Context) internal_realloc(
            null,
            168,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4320
        );
    fill_memory(result, 0, 168);

    result.max_iterations = 100;
    result.threshold = 0.000001;
    result.omega = 1.5;
    result.nb_systems = 1;
    return result;
}

internal_opennl_nl_delete_context :: (context_: *NL_Context) {
    internal_opennl_nl_delete_matrix(context_.m);
    context_.m = cast(NL_Matrix) null;
    internal_opennl_nl_delete_matrix(context_.p);
    context_.p = cast(NL_Matrix) null;
    internal_opennl_nl_delete_matrix(context_.b_2);
    context_.b_2 = cast(NL_Matrix) null;
    internal_opennl_nl_row_column_destroy(*context_.af);
    internal_opennl_nl_row_column_destroy(*context_.al);
    internal_realloc(
        cast(*void) context_.variable_value,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4339
    );

    context_.variable_value = cast(*float64) null;
    internal_realloc(
        cast(*void) context_.variable_buffer,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4340
    );

    context_.variable_buffer = cast(*NL_Buffer_Binding) null;
    internal_realloc(
        cast(*void) context_.variable_is_locked,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4341
    );

    context_.variable_is_locked = cast(*bool) null;
    internal_realloc(
        cast(*void) context_.variable_index,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4342
    );

    context_.variable_index = cast(*u32) null;
    internal_realloc(
        cast(*void) context_.x,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4343
    );

    context_.x = cast(*float64) null;
    internal_realloc(
        cast(*void) context_.b,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4344
    );

    context_.b = cast(*float64) null;
    internal_realloc(
        cast(*void) context_,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4345
    );

    context_ = cast(*NL_Context) null;
}

internal_opennl_nl_row_column_destroy :: (c_: *NL_Row_Column) {
    internal_realloc(
        cast(*void) c_.coeff,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4063
    );

    c_.coeff = cast(*NL_Coeff) null;
    c_.size = 0;
    c_.capacity = 0;
}

internal_opennl_nl_delete_matrix :: (m: NL_Matrix) {
    if m == null {
        return;
    }
    m.destroy_func(m);
    internal_realloc(
        cast(*void) m,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4046
    );

    m = cast(NL_Matrix) null;
}

internal_opennl_nl_get_variable :: (context_: *NL_Context, index: u32) -> float64 {
    assert(index >= 0 && index <= context_.nb_variables - 1);
    return (cast(*float64) (cast(*void) ((cast(*s8) context_.variable_buffer[0].base_address) + index * context_.variable_buffer[0].stride))).*;
}

internal_opennl_nl_solve :: (context_: *NL_Context) -> bool {
    internal_opennl_nl_delete_matrix(context_.p);
    context_.p = internal_opennl_nl_new_jacobi_preconditioner(context_.m);
    internal_opennl_nl_matrix_compress(*context_.m);
    result := internal_opennl_nl_solve_iterative(context_);
    internal_opennl_nl_vector_to_variables(context_);
    return result;
}

internal_opennl_nl_solve_iterative :: (context_: *NL_Context) -> bool {
    b := context_.b;
    x := context_.x;
    n := context_.n;
    m := context_.m;
    p := context_.p;
    {
        k: u32 = 0;
        while k < context_.nb_systems {
            internal_opennl_nl_solve_system_iterative(context_, m, p, b, x, context_.threshold, context_.max_iterations);
            b += n;
            x += n;
            k += 1;
        }
    }
    return true;
}

internal_opennl_nl_solve_system_iterative :: (
    context_: *NL_Context,
    m: NL_Matrix,
    p: NL_Matrix,
    b_in: *float64,
    x_in: *float64,
    eps: float64,
    max_iter: u32
) -> u32 {
    result: u32 = 0;
    rnorm: float64 = 0.0;
    bnorm: float64 = 0.0;
    b := b_in;
    x := x_in;
    assert(m.m == m.n);
    sq_bnorm, sq_rnorm: float64 = ---;
    result = internal_opennl_nl_solve_system_pre_cg(m, p, b, x, eps, max_iter, *sq_bnorm, *sq_rnorm);

    bnorm = sqrt(sq_bnorm);
    rnorm = sqrt(sq_rnorm);
    if bnorm == 0.0 {
        context_.error = rnorm;
    } else {
        context_.error = rnorm / bnorm;
    }
    context_.used_iterations = result;
    return result;
}

internal_opennl_nl_solve_system_pre_cg :: (
    m: NL_Matrix,
    p: NL_Matrix,
    b: *float64,
    x: *float64,
    eps: float64,
    max_iter: u32,
    sq_bnorm: *float64,
    sq_rnorm: *float64
) -> u32 {
    n := cast,no_check(s32) m.n;
    r :=
        cast(*float64) internal_realloc(
            null,
            8 * cast,no_check(u64) n,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4389
        );
    d :=
        cast(*float64) internal_realloc(
            null,
            8 * cast,no_check(u64) n,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4390
        );
    h :=
        cast(*float64) internal_realloc(
            null,
            8 * cast,no_check(u64) n,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4391
        );
    ad := h;
    its: u32 = 0;
    alpha: float64 = ---;
    beta: float64 = ---;
    b_square := internal_opennl_ddot(n, b, b);
    err := eps * eps * b_square;

    internal_opennl_nl_mult_matrix_vector(m, x, r);
    internal_opennl_daxpy(n, -cast(float64) 1.0, b, r);
    internal_opennl_nl_mult_matrix_vector(p, r, d);
    copy_memory(h, d, (cast,no_check(u64) n) * 8);
    rh := internal_opennl_ddot(n, r, h);
    curr_err := internal_opennl_ddot(n, r, r);
    while curr_err > err && its < max_iter {
        internal_opennl_nl_mult_matrix_vector(m, d, ad);
        alpha = rh / internal_opennl_ddot(n, d, ad);
        internal_opennl_daxpy(n, -alpha, d, x);
        internal_opennl_daxpy(n, -alpha, ad, r);
        internal_opennl_nl_mult_matrix_vector(p, r, h);
        beta = 1.0 / rh;
        rh = internal_opennl_ddot(n, r, h);
        beta *= rh;
        internal_opennl_dscal(n, beta, d);
        internal_opennl_daxpy(n, 1.0, h, d);
        its += 1;
        curr_err = internal_opennl_ddot(n, r, r);
    }
    internal_realloc(
        cast(*void) r,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4418
    );
    internal_realloc(
        cast(*void) d,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4419
    );
    internal_realloc(
        cast(*void) h,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4420
    );
    sq_bnorm.* = b_square;
    sq_rnorm.* = curr_err;
    return its;
}

internal_opennl_ddot :: (n: s32, x: *float64, y: *float64) -> float64 {
    sum: float64 = 0.0;
    if 0 < n {
        for i: 0..n - 1 {
            sum += x[i] * y[i];
        }
    }
    return sum;
}

internal_opennl_daxpy :: (n: s32, a: float64, x: *float64, y: *float64) {
    if 0 < n {
        for i: 0..n - 1 {
            y[i] = a * x[i] + y[i];
        }
    }
}

internal_opennl_dscal :: (n: s32, a: float64, x: *float64) {
    if 0 < n {
        for i: 0..n - 1 {
            x[i] *= a;
        }
    }
}

internal_opennl_nl_mult_matrix_vector :: (m: NL_Matrix, x: *float64, y: *float64) {
    m.mult_func(m, x, y);
}

internal_opennl_nl_vector_to_variables :: (context_: *NL_Context) {
    n := context_.n;
    assert(context_.x != null);
    {
        k: u32 = 0;
        while k < context_.nb_systems {
            {
                i: u32 = 0;
                while i < context_.nb_variables {
                    if !context_.variable_is_locked[i] {
                        index := context_.variable_index[i];
                        assert(index < context_.n);
                        value := context_.x[index + k * n];
                        assignment_36: float64 = value;
                        ((cast(*float64) (cast(*void) ((cast(*s8) context_.variable_buffer[k].base_address) + i * context_.variable_buffer[k].stride))).*) = assignment_36;
                    }
                    i += 1;
                }
            }
            k += 1;
        }
    }
}

internal_opennl_nl_matrix_compress :: (m: *NL_Matrix) {
    crs: NL_Matrix = cast(NL_Matrix) null;
    if m.*.type != 0x1001 {
        return;
    }
    crs = internal_opennl_nl_crs_matrix_new_from_sparse_matrix(cast(*NL_Sparse_Matrix) m.*);
    internal_opennl_nl_delete_matrix(m.*);
    m.* = crs;
}

internal_opennl_nl_crs_matrix_new_from_sparse_matrix :: (m: *NL_Sparse_Matrix) -> NL_Matrix {
    nnz := internal_opennl_nl_sparse_matrix_nnz(m);
    nslices: u32 = 8;
    slice, cur_bound, cur_nnz, cur_row: u32 = ---;

    slice_size := nnz / nslices;
    crs :=
        cast(*NLCRS_Matrix) internal_realloc(
            null,
            72,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4272
        );
    fill_memory(crs, 0, 72);

    internal_opennl_nl_crs_matrix_construct(crs, m.m, m.n, nnz, nslices);
    internal_opennl_nl_sparse_matrix_sort(m);

    k: u32 = 0;
    {
        i: u32 = 0;
        while i < m.m {
            ri := *m.row[i];
            crs.rowptr[i] = k;
            {
                ij: u32 = 0;
                while ij < ri.size {
                    c_ := *ri.coeff[ij];
                    crs.val[k] = c_.value;
                    crs.colind[k] = c_.index;
                    k += 1;
                    ij += 1;
                }
            }
            i += 1;
        }
    }
    crs.rowptr[m.m] = k;

    if crs.sliceptr != null {
        cur_bound = slice_size;
        cur_nnz = 0;
        cur_row = 0;
        crs.sliceptr[0] = 0;
        slice = 1;
        while slice < nslices {
            while cur_nnz < cur_bound && cur_row < m.m {
                cur_nnz += crs.rowptr[cur_row + 1] - crs.rowptr[cur_row];
                cur_row += 1;
            }
            crs.sliceptr[slice] = cur_row;
            cur_bound += slice_size;
            slice += 1;
        }
        crs.sliceptr[nslices] = m.m;
    }
    return cast(NL_Matrix) crs;
}

internal_opennl_nl_sparse_matrix_nnz :: (m: *NL_Sparse_Matrix) -> u32 {
    nnz: u32 = 0;
    {
        i: u32 = 0;
        while i < m.m {
            nnz += m.row[i].size;
            i += 1;
        }
    }
    return nnz;
}

internal_opennl_nl_sparse_matrix_sort :: (m: *NL_Sparse_Matrix) {
    {
        i: u32 = 0;
        while i < m.m {
            internal_opennl_nl_row_column_sort(*m.row[i]);
            i += 1;
        }
    }
}

internal_opennl_nl_row_column_sort :: (c_: *NL_Row_Column) {
    qsort(
        cast(*void) c_.coeff,
        cast,no_check(u64) c_.size,
        16,
        cast,no_check(compar_fn_t) internal_opennl_nl_coeff_compare
    );
}

internal_opennl_nl_coeff_compare :: (p1: *void, p2: *void) -> s32 {
    if (cast(*NL_Coeff) p2).index < (cast(*NL_Coeff) p1).index {
        return 1;
    }
    return 0;
}

internal_opennl_nl_crs_matrix_construct :: (m_2: *NLCRS_Matrix, m: u32, n: u32, nnz: u32, nslices: u32) {
    m_2.m = m;
    m_2.n = n;
    m_2.type = 0x1002;
    m_2.destroy_func = cast(NL_Destroy_Matrix_Func) internal_opennl_nl_crs_matrix_destroy;
    m_2.mult_func = cast(NL_Mult_Matrix_Vector_Func) internal_opennl_nl_crs_matrix_mult;
    m_2.nslices = nslices;
    m_2.val =
        cast(*float64) internal_realloc(
            null,
            8 * cast(u64) nnz,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4165
        );
    fill_memory(m_2.val, 0, (cast,no_check(u64) nnz) * 8);
    m_2.rowptr =
        cast(*u32) internal_realloc(
            null,
            4 * cast(u64) (m + 1),
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4167
        );
    fill_memory(m_2.rowptr, 0, (cast,no_check(u64) (m + 1)) * 4);
    m_2.colind =
        cast(*u32) internal_realloc(
            null,
            4 * cast(u64) nnz,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4169
        );
    fill_memory(m_2.colind, 0, (cast,no_check(u64) nnz) * 4);
    m_2.sliceptr =
        cast(*u32) internal_realloc(
            null,
            4 * cast(u64) (nslices + 1),
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4171
        );
    fill_memory(m_2.sliceptr, 0, (cast,no_check(u64) (nslices + 1)) * 4);
}

internal_opennl_nl_crs_matrix_mult :: (m: *NLCRS_Matrix, x: *float64, y: *float64) {
    nslices := cast,no_check(s32) m.nslices;
    if 0 < nslices {
        for slice: 0..nslices - 1 {
            internal_opennl_nl_crs_matrix_mult_slice(m, x, y, m.sliceptr[slice], m.sliceptr[slice + 1]);
        }
    }
}

internal_opennl_nl_crs_matrix_mult_slice :: (m: *NLCRS_Matrix, x: *float64, y: *float64, ibegin: u32, iend: u32) {
    {
        i := ibegin;
        while i < iend {
            sum: float64 = 0.0;
            {
                j := m.rowptr[i];
                while j < m.rowptr[i + 1] {
                    sum += m.val[j] * x[m.colind[j]];
                    j += 1;
                }
            }
            y[i] = sum;
            i += 1;
        }
    }
}

internal_opennl_nl_crs_matrix_destroy :: (m: *NLCRS_Matrix) {
    internal_realloc(
        cast(*void) m.val,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4131
    );

    m.val = cast(*float64) null;
    internal_realloc(
        cast(*void) m.rowptr,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4132
    );

    m.rowptr = cast(*u32) null;
    internal_realloc(
        cast(*void) m.colind,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4133
    );

    m.colind = cast(*u32) null;
    internal_realloc(
        cast(*void) m.sliceptr,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4134
    );

    m.sliceptr = cast(*u32) null;
    m.m = 0;
    m.n = 0;
    m.nslices = 0;
}

internal_opennl_nl_new_jacobi_preconditioner :: (m_in: NL_Matrix) -> NL_Matrix {
    m: *NL_Sparse_Matrix = cast(*NL_Sparse_Matrix) null;
    result: *NL_Jacobi_Preconditioner = cast(*NL_Jacobi_Preconditioner) null;
    assert(m_in.type == 0x1001);
    assert(m_in.m == m_in.n);
    m = cast(*NL_Sparse_Matrix) m_in;
    result =
        cast(*NL_Jacobi_Preconditioner) internal_realloc(
            null,
            40,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4490
        );
    fill_memory(result, 0, 40);

    result.m = m.m;
    result.n = m.n;
    result.type = 0x1006;
    result.destroy_func = cast(NL_Destroy_Matrix_Func) internal_opennl_nl_jacobi_preconditioner_destroy;
    result.mult_func = cast(NL_Mult_Matrix_Vector_Func) internal_opennl_nl_jacobi_preconditioner_mult;
    result.diag_inv =
        cast(*float64) internal_realloc(
            null,
            8 * cast(u64) m.n,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4497
        );
    fill_memory(result.diag_inv, 0, (cast,no_check(u64) m.n) * 8);
    {
        i: u32 = 0;
        while i < m.n {
            result.diag_inv[i] = ifx m.diag[i] == 0.0 then 1.0 else 1.0 / m.diag[i];
            i += 1;
        }
    }
    return cast(NL_Matrix) result;
}

internal_opennl_nl_jacobi_preconditioner_mult :: (m: *NL_Jacobi_Preconditioner, x: *float64, y: *float64) {
    {
        i: u32 = 0;
        while i < m.n {
            y[i] = x[i] * m.diag_inv[i];
            i += 1;
        }
    }
}

internal_opennl_nl_jacobi_preconditioner_destroy :: (m: *NL_Jacobi_Preconditioner) {
    internal_realloc(
        cast(*void) m.diag_inv,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4474
    );

    m.diag_inv = cast(*float64) null;
}

internal_opennl_nl_end :: (context_: *NL_Context, prim: u32) {
    if prim == 0x1 {
        internal_opennl_nl_row_column_clear(*context_.af);
        internal_opennl_nl_row_column_clear(*context_.al);
    } else if prim == 0x2 {
        af := *context_.af;
        al := *context_.al;
        m := cast(*NL_Sparse_Matrix) context_.m;
        b := context_.b;
        nf := af.size;
        nl := al.size;
        n := context_.n;
        s: float64 = ---;

        if 0 < nf {
            for i: 0..nf - 1 {
                if 0 < nf {
                    for j_2: 0..nf - 1 {
                        internal_opennl_nl_sparse_matrix_add(
                            m,
                            af.coeff[i].index,
                            af.coeff[j_2].index,
                            af.coeff[i].value * af.coeff[j_2].value
                        );
                    }
                }
            }
        }
        {
            k: u32 = 0;
            while k < context_.nb_systems {
                s = 0.0;
                if 0 < nl {
                    for jj_2: 0..nl - 1 {
                        j := al.coeff[jj_2].index;
                        s +=
                            al.coeff[jj_2].value *
                                (cast(*float64) (cast(*void) ((cast(*s8) context_.variable_buffer[k].base_address) + j * context_.variable_buffer[k].stride))).*;
                    }
                }
                if 0 < nf {
                    for jj: 0..nf - 1 {
                        b[k * n + af.coeff[jj].index] -= af.coeff[jj].value * s;
                    }
                }
                k += 1;
            }
        }
        context_.current_row += 1;
    }
}

internal_opennl_nl_sparse_matrix_add :: (m: *NL_Sparse_Matrix, i: u32, j: u32, value: float64) {
    assert(i >= 0 && i <= m.m - 1);
    assert(j >= 0 && j <= m.n - 1);
    if i == j {
        m.diag[i] += value;
    }
    internal_opennl_nl_row_column_add(*m.row[i], j, value);
}

internal_opennl_nl_row_column_add :: (c_: *NL_Row_Column, index: u32, value: float64) {
    {
        i: u32 = 0;
        while i < c_.size {
            if c_.coeff[i].index == index {
                c_.coeff[i].value += value;
                return;
            }
            i += 1;
        }
    }
    if c_.size == c_.capacity {
        internal_opennl_nl_row_column_grow(c_);
    }
    c_.coeff[c_.size].index = index;
    c_.coeff[c_.size].value = value;
    c_.size += 1;
}

internal_opennl_nl_row_column_grow :: (c_: *NL_Row_Column) {
    if c_.capacity != 0 {
        c_.capacity = 2 * c_.capacity;
        c_.coeff =
            cast(*NL_Coeff) internal_realloc(
                cast(*void) c_.coeff,
                16 * cast(u64) c_.capacity,
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4072
            );
    } else {
        c_.capacity = 4;
        c_.coeff =
            cast(*NL_Coeff) internal_realloc(
                null,
                16 * cast(u64) c_.capacity,
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4075
            );
        fill_memory(c_.coeff, 0, (cast,no_check(u64) c_.capacity) * 16);
    }
}

internal_opennl_nl_row_column_clear :: (c_: *NL_Row_Column) {
    c_.size = 0;
    c_.capacity = 0;
    internal_realloc(
        cast(*void) c_.coeff,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4114
    );

    c_.coeff = cast(*NL_Coeff) null;
}

internal_opennl_nl_coefficient :: (context_: *NL_Context, index: u32, value: float64) {
    assert(index >= 0 && index <= context_.nb_variables - 1);
    if context_.variable_is_locked[index] {
        internal_opennl_nl_row_column_append(*context_.al, index, value);
    } else {
        internal_opennl_nl_row_column_append(*context_.af, context_.variable_index[index], value);
    }
}

internal_opennl_nl_row_column_append :: (c_: *NL_Row_Column, index: u32, value: float64) {
    if c_.size == c_.capacity {
        internal_opennl_nl_row_column_grow(c_);
    }
    c_.coeff[c_.size].index = index;
    c_.coeff[c_.size].value = value;
    c_.size += 1;
}

internal_opennl_nl_begin :: (context_: *NL_Context, prim: u32) {
    if prim == 0 {
        assert(context_.nb_variables > 0);
        context_.variable_buffer =
            cast(*NL_Buffer_Binding) internal_realloc(
                null,
                16 * cast(u64) context_.nb_systems,
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4595
            );
        fill_memory(context_.variable_buffer, 0, (cast,no_check(u64) context_.nb_systems) * 16);
        context_.variable_value =
            cast(*float64) internal_realloc(
                null,
                8 * cast(u64) (context_.nb_variables * context_.nb_systems),
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4597
            );
        fill_memory(context_.variable_value, 0, (cast,no_check(u64) (context_.nb_variables * context_.nb_systems)) * 8);
        {
            k: u32 = 0;
            while k < context_.nb_systems {
                context_.variable_buffer[k].base_address =
                    cast(*void) (context_.variable_value +
                        k * context_.nb_variables);
                context_.variable_buffer[k].stride = 8;
                k += 1;
            }
        }
        context_.variable_is_locked =
            cast(*bool) internal_realloc(
                null,
                cast,no_check(u64) context_.nb_variables,
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4605
            );
        fill_memory(context_.variable_is_locked, 0, cast,no_check(u64) context_.nb_variables);
        context_.variable_index =
            cast(*u32) internal_realloc(
                null,
                4 * cast(u64) context_.nb_variables,
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4607
            );
        fill_memory(context_.variable_index, 0, (cast,no_check(u64) context_.nb_variables) * 4);
    } else if prim == 0x1 {
        if context_.m != null {
            return;
        }
        n: u32 = 0;
        {
            i: u32 = 0;
            while i < context_.nb_variables {
                if !context_.variable_is_locked[i] {
                    context_.variable_index[i] = n;
                    n += 1;
                } else {
                    context_.variable_index[i] = cast,no_check(u32) (~(cast(s32) 0));
                }
                i += 1;
            }
        }
        context_.n = n;
        if !context_.max_iterations_defined {
            context_.max_iterations = n * 5;
        }
        context_.m =
            cast(NL_Matrix) (cast(*NL_Sparse_Matrix) internal_realloc(
                null,
                72,
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4623
            ));
        fill_memory(context_.m, 0, 72);

        internal_opennl_nl_sparse_matrix_construct(cast(*NL_Sparse_Matrix) context_.m, n, n);
        context_.x =
            cast(*float64) internal_realloc(
                null,
                8 * cast(u64) (n * context_.nb_systems),
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4626
            );
        fill_memory(context_.x, 0, (cast,no_check(u64) (n * context_.nb_systems)) * 8);
        context_.b =
            cast(*float64) internal_realloc(
                null,
                8 * cast(u64) (n * context_.nb_systems),
                cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                4628
            );
        fill_memory(context_.b, 0, (cast,no_check(u64) (n * context_.nb_systems)) * 8);
        internal_opennl_nl_variables_to_vector(context_);
        internal_opennl_nl_row_column_construct(*context_.af);
        internal_opennl_nl_row_column_construct(*context_.al);
        context_.current_row = 0;
    } else if prim == 0x2 {
        internal_opennl_nl_row_column_zero(*context_.af);
        internal_opennl_nl_row_column_zero(*context_.al);
    }
}

internal_opennl_nl_row_column_zero :: (c_: *NL_Row_Column) {
    c_.size = 0;
}

internal_opennl_nl_row_column_construct :: (c_: *NL_Row_Column) {
    c_.size = 0;
    c_.capacity = 0;
    c_.coeff = cast(*NL_Coeff) null;
}

internal_opennl_nl_variables_to_vector :: (context_: *NL_Context) {
    n := context_.n;
    assert(context_.x != null);
    {
        k: u32 = 0;
        while k < context_.nb_systems {
            {
                i: u32 = 0;
                while i < context_.nb_variables {
                    if !context_.variable_is_locked[i] {
                        index := context_.variable_index[i];
                        assert(index < context_.n);
                        value :=
                            (cast(*float64) (cast(*void) ((cast(*s8) context_.variable_buffer[k].base_address) +
                                i * context_.variable_buffer[k].stride))).*;
                        context_.x[index + k * n] = value;
                    }
                    i += 1;
                }
            }
            k += 1;
        }
    }
}

internal_opennl_nl_sparse_matrix_construct :: (m_2: *NL_Sparse_Matrix, m: u32, n: u32) {
    m_2.m = m;
    m_2.n = n;
    m_2.type = 0x1001;
    m_2.destroy_func = cast(NL_Destroy_Matrix_Func) internal_opennl_nl_sparse_matrix_destroy;
    m_2.mult_func = cast(NL_Mult_Matrix_Vector_Func) internal_opennl_nl_sparse_matrix_mult;
    m_2.row =
        cast(*NL_Row_Column) internal_realloc(
            null,
            16 * cast(u64) m,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4251
        );
    fill_memory(m_2.row, 0, (cast,no_check(u64) m) * 16);
    m_2.row_capacity = m;
    if 0 < n {
        for i: 0..n - 1 {
            internal_opennl_nl_row_column_construct(*m_2.row[i]);
        }
    }
    m_2.row_capacity = 0;
    m_2.column = cast(*NL_Row_Column) null;
    m_2.column_capacity = 0;
    m_2.diag_size = internal_min(*m, *n);
    m_2.diag_capacity = m_2.diag_size;
    m_2.diag =
        cast(*float64) internal_realloc(
            null,
            8 * cast(u64) m_2.diag_size,
            cast(s32) INTERNAL_MEM_TAG_OPEN_NL,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            4261
        );
    fill_memory(m_2.diag, 0, (cast,no_check(u64) m_2.diag_size) * 8);
}

internal_opennl_nl_sparse_matrix_mult :: (a: *NL_Sparse_Matrix, x: *float64, y: *float64) {
    assert(a.type == 0x1001);
    internal_opennl_nl_sparse_matrix_mult_rows(a, x, y);
}

internal_opennl_nl_sparse_matrix_mult_rows :: (a: *NL_Sparse_Matrix, x: *float64, y: *float64) {
    m := cast,no_check(s32) a.m;
    c_: *NL_Coeff = cast(*NL_Coeff) null;
    ri: *NL_Row_Column = cast(*NL_Row_Column) null;
    if 0 < m {
        for i: 0..m - 1 {
            ri = *a.row[i];
            y[i] = 0;
            {
                ij: s32 = 0;
                while ij < cast,no_check(s32) ri.size {
                    c_ = *ri.coeff[ij];
                    y[i] += c_.value * x[c_.index];
                    ij += 1;
                }
            }
        }
    }
}

internal_opennl_nl_sparse_matrix_destroy :: (m: *NL_Sparse_Matrix) {
    assert(m.type == 0x1001);
    internal_opennl_nl_sparse_matrix_destroy_row_columns(m);
    internal_realloc(
        cast(*void) m.diag,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4188
    );

    m.diag = cast(*float64) null;
}

internal_opennl_nl_sparse_matrix_destroy_row_columns :: (m: *NL_Sparse_Matrix) {
    {
        i: u32 = 0;
        while i < m.m {
            internal_opennl_nl_row_column_destroy(*m.row[i]);
            i += 1;
        }
    }
    internal_realloc(
        cast(*void) m.row,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        4181
    );

    m.row = cast(*NL_Row_Column) null;
}

internal_param_project_triangle :: (p0: Vector3, p1: Vector3, p2: Vector3, z0: *Vector2, z1: *Vector2, z2: *Vector2) {
    local_p0: Vector3 = p0;
    local_p1: Vector3 = p1;
    local_p2: Vector3 = p2;
    x :=
        internal_normalize(
            (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(*local_p1, *local_p0); *temporary___g0; })
        );
    z :=
        internal_normalize(
            (ifx true { temporary___g2: Vector3 = internal_cross(
            *x,
            (ifx true { temporary___g1: Vector3 = internal_operator_in_xatlas_2(*local_p2, *local_p0); *temporary___g1; })
        ); *temporary___g2; })
        );
    y := internal_cross(*z, *x);
    o := *local_p0;
    assign(z0, (ifx true { temporary___g4: Vector2 = make_vector2(0, 0); *temporary___g4; }));
    assign(
        z1,
        (ifx true { temporary___g6: Vector2 = make_vector2(
        internal_length(
        (ifx true { temporary___g3: Vector3 = internal_operator_in_xatlas_2(*local_p1, o); *temporary___g3; })
    ),
        0
    ); *temporary___g6; })
    );
    assign(
        z2,
        (ifx true { temporary___g7: Vector2 = make_vector2(
        internal_dot(
        (ifx true { temporary___g5: Vector3 = internal_operator_in_xatlas_2(*local_p2, o); *temporary___g5; }),
        *x
    ),
        internal_dot(
        (ifx true { temporary___g8: Vector3 = internal_operator_in_xatlas_2(*local_p2, o); *temporary___g8; }),
        *y
    )
    ); *temporary___g7; })
    );
}

internal_param_setup_abf_relations :: (
    context_: *NL_Context,
    id0: s32,
    id1: s32,
    id2: s32,
    p0: *Vector3,
    p1: *Vector3,
    p2: *Vector3
) -> bool {
    a0, a1, a2: float32 = ---;
    internal_param_triangle_angles(p0, p1, p2, *a0, *a1, *a2);
    if a0 == 0.0 || a1 == 0.0 || a2 == 0.0 {
        return false;
    }
    s0 := sinf(a0);
    s1 := sinf(a1);
    s2 := sinf(a2);
    if s1 > s0 && s1 > s2 {
        internal_swap(*s1, *s2);
        internal_swap(*s0, *s1);
        internal_swap(*a1, *a2);
        internal_swap(*a0, *a1);
        internal_swap(*id1, *id2);
        internal_swap(*id0, *id1);
    } else if s0 > s1 && s0 > s2 {
        internal_swap(*s0, *s2);
        internal_swap(*s0, *s1);
        internal_swap(*a0, *a2);
        internal_swap(*a0, *a1);
        internal_swap(*id0, *id2);
        internal_swap(*id0, *id1);
    }
    c0 := cosf(a0);
    ratio := (ifx s2 == 0.0 then 1.0 else s1 / s2);
    cosine := c0 * ratio;
    sine := s0 * ratio;

    u0_id := 2 * id0 + 0;
    v0_id := 2 * id0 + 1;
    u1_id := 2 * id1 + 0;
    v1_id := 2 * id1 + 1;
    u2_id := 2 * id2 + 0;
    v2_id := 2 * id2 + 1;

    internal_opennl_nl_begin(context_, 0x2);
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) u0_id, cast,no_check(float64) (cosine - 1.0));
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) v0_id, cast,no_check(float64) (-sine));
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) u1_id, cast,no_check(float64) (-cosine));
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) v1_id, cast,no_check(float64) sine);
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) u2_id, 1);
    internal_opennl_nl_end(context_, 0x2);

    internal_opennl_nl_begin(context_, 0x2);
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) u0_id, cast,no_check(float64) sine);
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) v0_id, cast,no_check(float64) (cosine - 1.0));
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) u1_id, cast,no_check(float64) (-sine));
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) v1_id, cast,no_check(float64) (-cosine));
    internal_opennl_nl_coefficient(context_, cast,no_check(u32) v2_id, 1);
    internal_opennl_nl_end(context_, 0x2);
    return true;
}

internal_param_triangle_angles :: (v1: *Vector3, v2: *Vector3, v3: *Vector3, a1: *float32, a2: *float32, a3: *float32) {
    a1.* = internal_param_vec_angle(v3, v1, v2);
    a2.* = internal_param_vec_angle(v1, v2, v3);
    a3.* = K_PI - a2.* - a1.*;
}

internal_param_vec_angle :: (v1: *Vector3, v2: *Vector3, v3: *Vector3) -> float32 {
    dot := internal_param_vec_angle_cos(v1, v2, v3);
    return acosf(dot);
}

internal_param_vec_angle_cos :: (v1: *Vector3, v2: *Vector3, v3: *Vector3) -> float32 {
    d1 := internal_operator_in_xatlas_2(v1, v2);
    d2 := internal_operator_in_xatlas_2(v3, v2);
    return internal_clamp(
        (ifx true { temporary___g0: float32 = (internal_dot(*d1, *d2) /
        (internal_length(*d1) * internal_length(*d2))); *temporary___g0; }),
        (ifx true { temporary___g1: float32 = -1.0; *temporary___g1; }),
        (ifx true { temporary___g2: float32 = 1.0; *temporary___g2; })
    );
}

internal_clamp :: (x: *float32, a: *float32, b: *float32) -> float32 {
    return internal_min((ifx true { temporary___g0: float32 = internal_max(x, a); *temporary___g0; }), b);
}

internal_opennl_nl_lock_variable :: (context_: *NL_Context, index: u32) {
    assert(index >= 0 && index <= context_.nb_variables - 1);
    context_.variable_is_locked[index] = true;
}

internal_opennl_nl_set_variable :: (context_: *NL_Context, index: u32, value: float64) {
    assert(index >= 0 && index <= context_.nb_variables - 1);
    assignment_37: float64 = value;
    ((cast(*float64) (cast(*void) ((cast(*s8) context_.variable_buffer[0].base_address) + index * context_.variable_buffer[0].stride))).*) = assignment_37;
}

internal_opennl_nl_solver_parameteri :: (context_: *NL_Context, pname: u32, param: s32) {
    if pname == 0x101 {
        assert(param > 0);
        context_.nb_variables = cast,no_check(u32) param;
    } else if pname == 0x103 {
        assert(param > 0);
        context_.max_iterations = cast,no_check(u32) param;
        context_.max_iterations_defined = true;
    }
}

internal_param_find_approximate_diameter_vertices :: (mesh: *Internal_Mesh, a: *u32, b: *u32) -> bool {
    assert(a != null);
    assert(b != null);
    VERTEX_COUNT := vertex_count(mesh);
    min_vertex: [3] u32 = ---;
    max_vertex: [3] u32 = ---;
    min_vertex[2] = 4294967295;
    min_vertex[1] = min_vertex[2];
    min_vertex[0] = min_vertex[1];
    max_vertex[2] = 4294967295;
    max_vertex[1] = max_vertex[2];
    max_vertex[0] = max_vertex[1];
    if 1 < VERTEX_COUNT {
        for v_2: 1..VERTEX_COUNT - 1 {
            if is_boundary_vertex(mesh, v_2) {
                min_vertex[2] = v_2;
                min_vertex[1] = min_vertex[2];
                min_vertex[0] = min_vertex[1];
                max_vertex[2] = v_2;
                max_vertex[1] = max_vertex[2];
                max_vertex[0] = max_vertex[1];
                break;
            }
        }
    }
    if min_vertex[0] == 4294967295 {
        return false;
    }
    if 1 < VERTEX_COUNT {
        for v: 1..VERTEX_COUNT - 1 {
            if !is_boundary_vertex(mesh, v) {
                continue;
            }
            pos: *Vector3 = cast,no_check(*Vector3) position(mesh, v);
            if pos.x < (position(mesh, min_vertex[0])).x {
                min_vertex[0] = v;
            } else if pos.x > (position(mesh, max_vertex[0])).x {
                max_vertex[0] = v;
            }
            if pos.y < (position(mesh, min_vertex[1])).y {
                min_vertex[1] = v;
            } else if pos.y > (position(mesh, max_vertex[1])).y {
                max_vertex[1] = v;
            }
            if pos.z < (position(mesh, min_vertex[2])).z {
                min_vertex[2] = v;
            } else if pos.z > (position(mesh, max_vertex[2])).z {
                max_vertex[2] = v;
            }
        }
    }
    lengths: [3] float32 = ---;
    for i: 0..cast(s32) 3 - 1 {
        (ifx true { assignment_38: float32 = cast,no_check(float32) (internal_length(
            (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(position(mesh, min_vertex[i]), position(mesh, max_vertex[i])); *temporary___g0; })
        )); (lengths[i]) = assignment_38; assignment_38; });
    }
    if lengths[0] > lengths[1] && lengths[0] > lengths[2] {
        a.* = min_vertex[0];
        b.* = max_vertex[0];
    } else if lengths[1] > lengths[2] {
        a.* = min_vertex[1];
        b.* = max_vertex[1];
    } else {
        a.* = min_vertex[2];
        b.* = max_vertex[2];
    }
    return true;
}

index_count :: (using mesh: *Internal_Mesh) -> u32 {
    return size(*indices);
}

compute_metrics :: (using quality_2: *Quality, mesh: *Internal_Mesh) {
    total_parametric_area = 0.0;
    total_geometric_area = total_parametric_area;
    authalic_metric = 0.0;
    conformal_metric = authalic_metric;
    max_stretch_metric = conformal_metric;
    stretch_metric = max_stretch_metric;
    FACE_COUNT := face_count(mesh);
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            pos: [3] Vector3 = ---;
            {
                cpp_transpiler_fixed_array_index_g59: u64 = 0;
                while cpp_transpiler_fixed_array_index_g59 < 3 {
                    init(*pos[cpp_transpiler_fixed_array_index_g59]);
                    cpp_transpiler_fixed_array_index_g59 += 1;
                }
            }
            texcoord_3: [3] Vector2 = ---;
            {
                cpp_transpiler_fixed_array_index_g60: u64 = 0;
                while cpp_transpiler_fixed_array_index_g60 < 3 {
                    init(*texcoord_3[cpp_transpiler_fixed_array_index_g60]);
                    cpp_transpiler_fixed_array_index_g60 += 1;
                }
            }
            for i: 0..cast(s32) 3 - 1 {
                V := vertex_at(mesh, (f * 3) + cast,no_check(u32) i);
                assign_7(pos.data + i, position(mesh, V));
                assign_3(texcoord_3.data + i, texcoord_2(mesh, V));
            }

            T1 := texcoord_3[0].x;
            S1 := texcoord_3[0].y;
            T2 := texcoord_3[1].x;
            S2 := texcoord_3[1].y;
            T3 := texcoord_3[2].x;
            S3 := texcoord_3[2].y;
            parametric_area_2 := ((S2 - S1) * (T3 - T1) - (S3 - S1) * (T2 - T1)) * 0.5;
            if internal_is_zero(parametric_area_2, K_AREA_EPSILON) {
                continue;
            }
            if parametric_area_2 < 0.0 {
                parametric_area_2 = fabsf(parametric_area_2);
            }
            GEOMETRIC_AREA :=
                internal_length(
                    (ifx true { temporary___g2: Vector3 = internal_cross(
                    (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(pos.data +
                    1, pos.data + 0); *temporary___g0; }),
                    (ifx true { temporary___g1: Vector3 = internal_operator_in_xatlas_2(pos.data +
                    2, pos.data + 0); *temporary___g1; })
                ); *temporary___g2; })
                ) / cast(s32) 2;
            SS :=
                internal_operator_in_xatlas(
                    (ifx true { temporary___g8: Vector3 = internal_operator(
                    (ifx true { temporary___g6: Vector3 = internal_operator(
                    (ifx true { temporary___g4: Vector3 = internal_operator(pos.data + 0, T2 - T3); *temporary___g4; }),
                    (ifx true { temporary___g3: Vector3 = internal_operator(pos.data + 1, T3 - T1); *temporary___g3; })
                ); *temporary___g6; }),
                    (ifx true { temporary___g5: Vector3 = internal_operator(pos.data + 2, T1 - T2); *temporary___g5; })
                ); *temporary___g8; }),
                    (cast(s32) 2) * parametric_area_2
                );
            ST :=
                internal_operator_in_xatlas(
                    (ifx true { temporary___g12: Vector3 = internal_operator(
                    (ifx true { temporary___g10: Vector3 = internal_operator(
                    (ifx true { temporary___g7: Vector3 = internal_operator(pos.data + 0, S3 - S2); *temporary___g7; }),
                    (ifx true { temporary___g9: Vector3 = internal_operator(pos.data + 1, S1 - S3); *temporary___g9; })
                ); *temporary___g10; }),
                    (ifx true { temporary___g11: Vector3 = internal_operator(pos.data + 2, S2 - S1); *temporary___g11; })
                ); *temporary___g12; }),
                    (cast(s32) 2) * parametric_area_2
                );
            A := internal_dot(*SS, *SS);
            B := internal_dot(*SS, *ST);
            C := internal_dot(*ST, *ST);

            SIGMA1 :=
                sqrtf(
                    0.5 * internal_max(
                    (ifx true { temporary___g13: float32 = 0.0; *temporary___g13; }),
                    (ifx true { temporary___g15: float32 = (A + C -
                    sqrtf(internal_square(A - C) + (cast(s32) 4) * internal_square(B))); *temporary___g15; })
                )
                );
            SIGMA2 :=
                sqrtf(
                    0.5 * internal_max(
                    (ifx true { temporary___g16: float32 = 0.0; *temporary___g16; }),
                    (ifx true { temporary___g17: float32 = (A + C +
                    sqrtf(internal_square(A - C) + (cast(s32) 4) * internal_square(B))); *temporary___g17; })
                )
                );
            if !(SIGMA2 > SIGMA1 || internal_equal(SIGMA1, SIGMA2, K_EPSILON)) {
                if s_print != null {
                    s_print(
                        c_string("\rASSERT: %s %s %d\n"),
                        c_string("sigma2 > sigma1 || equal(sigma1, sigma2, kEpsilon)"),
                        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                        cast(s32) 7093
                    );
                }
            }

            RMS_STRETCH := sqrtf((A + C) * 0.5);
            RMS_STRETCH2 := sqrtf((internal_square(SIGMA1) + internal_square(SIGMA2)) * 0.5);
            assert(internal_equal(RMS_STRETCH, RMS_STRETCH2, 0.01));

            stretch_metric += internal_square(RMS_STRETCH) * GEOMETRIC_AREA;
            max_stretch_metric = internal_max(*max_stretch_metric, *SIGMA2);
            if !internal_is_zero(SIGMA1, 0.000001) {
                conformal_metric += SIGMA2 / SIGMA1 * GEOMETRIC_AREA;
            }
            authalic_metric += SIGMA1 * SIGMA2 * GEOMETRIC_AREA;

            total_geometric_area += GEOMETRIC_AREA;
            total_parametric_area += parametric_area_2;
        }
    }
    assert(internal_is_finite(total_parametric_area) && total_parametric_area >= 0);
    assert(internal_is_finite(total_geometric_area) && total_geometric_area >= 0);
    assert(internal_is_finite(stretch_metric));
    assert(internal_is_finite(max_stretch_metric));
    assert(internal_is_finite(conformal_metric));
    assert(internal_is_finite(authalic_metric));
    if total_geometric_area > 0.0 {
        NORM_FACTOR := sqrtf(total_parametric_area / total_geometric_area);
        stretch_metric = sqrtf(stretch_metric / total_geometric_area) * NORM_FACTOR;
        max_stretch_metric *= NORM_FACTOR;
        conformal_metric = sqrtf(conformal_metric / total_geometric_area);
        authalic_metric = sqrtf(authalic_metric / total_geometric_area);
    }
}

assign_7 :: inline (using vector3: *Vector3, unnamed_37614: *Vector3) -> *Vector3 {
    vector3.* = ((cast(**Vector3) *(unnamed_37614)).*).*;
    return (cast(**Vector3) *(vector3)).*;
}

chart_generator_type :: (using atlas: *Segment_Atlas, chart_index: u32) -> Chart_Generator_Type_Enum {
    if chart_index < chart_count(*original_uv_charts) {
        return INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_ORIGINAL_UV;
    }
    chart_index -= chart_count(*original_uv_charts);
    if chart_index < chart_count(*planar_charts) {
        return INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_PLANAR;
    }
    return INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_CLUSTERED;
}

chart_basis :: (using atlas: *Segment_Atlas, chart_index: u32) -> *Basis {
    if chart_index < chart_count(*original_uv_charts) {
        return chart_basis(*original_uv_charts, chart_index);
    }
    chart_index -= chart_count(*original_uv_charts);
    if chart_index < chart_count(*planar_charts) {
        return chart_basis(*planar_charts, chart_index);
    }
    chart_index -= chart_count(*planar_charts);
    return chart_basis(*clustered_charts, chart_index);
}

chart_basis :: (using clustered_charts: *Clustered_Charts, chart_index: u32) -> *Basis {
    return *(((cast(**Clustered_Charts_Chart) index_explicit_5(*charts, chart_index)).*).basis);
}

chart_basis :: (using planar_charts: *Planar_Charts, chart_index: u32) -> *Basis {
    return index_explicit_41(*chart_basis, chart_index);
}

index_explicit_41 :: (using array: *Array(Basis), index: u32) -> *Basis {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Basis) base.buffer)[index];
}

chart_basis :: (using original_uv_charts: *Original_Uv_Charts, chart_index: u32) -> *Basis {
    return index_explicit_41(*chart_basis, chart_index);
}

run_ctors :: (using array: *Array(Create_And_Parameterize_Chart_Task_Args)) {
    {
        i: u32 = 0;
        while i < base.size {
            (ifx true {
    cpp_transpiler_new_g61 :=
        cast(*Create_And_Parameterize_Chart_Task_Args) (cast(*void) (*(cast(*Create_And_Parameterize_Chart_Task_Args) base.buffer)[i]));
    init(cpp_transpiler_new_g61);
    cpp_transpiler_new_g61;
})
;
            i += 1;
        }
    }
}

resize :: (using array: *Array(Create_And_Parameterize_Chart_Task_Args), new_size: u32) {
    resize(*base, new_size, true);
}

create_mesh :: (using chart_group: *Chart_Group) -> *Internal_Mesh {
    assert(face_group != cast(u32) 4294967295);

    reserve(*face_to_source_face_map, face_count(source_mesh_face_groups, face_group));
    {
        it_: Mesh_Face_Groups_Iterator = ---;
        init(*it_, source_mesh_face_groups, face_group);
        while !is_done(*it_) {
            push_back(*face_to_source_face_map, (ifx true { temporary___g0: u32 = face(*it_); *temporary___g0; }));
            advance(*it_);
        }
    }

    FACE_COUNT := size(*face_to_source_face_map);
    assert(FACE_COUNT > 0);
    APPROX_VERTEX_COUNT: u32 =
        internal_min(
            (ifx true { temporary___g1: u32 = (FACE_COUNT * 3); *temporary___g1; }),
            (ifx true { temporary___g2: u32 = vertex_count(source_mesh); *temporary___g2; })
        );
    mesh :=
        cast(*Internal_Mesh) (cast(*void) (cast(*Internal_Mesh) internal_realloc(
            null,
            360,
            cast(s32) INTERNAL_MEM_TAG_MESH,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            7670
        )));
    init(
        mesh,
        epsilon(source_mesh),
        APPROX_VERTEX_COUNT,
        FACE_COUNT,
        flags(source_mesh) & INTERNAL_MESH_FLAGS_HAS_NORMALS,
        4294967295
    );
    source_vertex_to_vertex_map: Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)) = ---;
    defer deinit(*source_vertex_to_vertex_map);
    init(*source_vertex_to_vertex_map, cast(s32) INTERNAL_MEM_TAG_MESH, APPROX_VERTEX_COUNT);
    if 0 < FACE_COUNT {
        for f_2: 0..FACE_COUNT - 1 {
            FACE_2: u32 = ((cast(**u32) *(index_explicit(*face_to_source_face_map, f_2))).*).*;
            for i_2: 0..cast(u32) 3 - 1 {
                VERTEX_2 := vertex_at(source_mesh, (FACE_2 * 3) + i_2);
                if get(*source_vertex_to_vertex_map, *VERTEX_2) == 4294967295 {
                    add(*source_vertex_to_vertex_map, *VERTEX_2);
                    normal_2: Vector3 = make_vector3(0.0);
                    if flags(source_mesh) & INTERNAL_MESH_FLAGS_HAS_NORMALS != 0 {
                        assign_7(*normal_2, normal(source_mesh, VERTEX_2));
                    }
                    add_vertex(mesh, position(source_mesh, VERTEX_2), *normal_2, texcoord_2(source_mesh, VERTEX_2));
                }
            }
        }
    }

    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            FACE: u32 = ((cast(**u32) *(index_explicit(*face_to_source_face_map, f))).*).*;
            assert(!is_face_ignored(source_mesh, FACE));
            indices_2: [3] u32 = ---;
            for i: 0..cast(u32) 3 - 1 {
                VERTEX := vertex_at(source_mesh, (FACE * 3) + i);
                indices_2[i] = get(*source_vertex_to_vertex_map, *VERTEX);
                assert(indices_2[i] != 4294967295);
            }

            add_face(mesh, indices_2.data, false, 4294967295);
        }
    }

    create_colocals(mesh);

    create_boundaries(mesh);
    destroy_edge_map(mesh);

    return mesh;
}

destroy_edge_map :: (using mesh: *Internal_Mesh) {
    destroy(*edge_map);
}

destroy :: (using hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key))) {
    if slots != null {
        internal_realloc(
            cast(*void) slots,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1957
        );
        slots = cast(*u32) null;
    }
    destroy(*keys);
    destroy(*next);
}

destroy :: (using array: *Array(u32)) {
    destroy(*base);
}

destroy :: (using array: *Array(Edge_Key)) {
    destroy(*base);
}

create_boundaries :: (using mesh: *Internal_Mesh) {
    EDGE_COUNT := size(*indices);
    VERTEX_COUNT := size(*positions);
    resize(*opposite_edges, EDGE_COUNT);
    reserve(*boundary_edges, cast,no_check(u32) (EDGE_COUNT * 0.1));
    resize(*is_boundary_vertex, VERTEX_COUNT);
    zero_out_memory(*is_boundary_vertex);
    if 0 < EDGE_COUNT {
        for i_2: 0..EDGE_COUNT - 1 {
            ((cast(**u32) *(index_explicit(*opposite_edges, i_2))).*).* = 4294967295;
        }
    }
    FACE_COUNT := size(*indices) / 3;
    if 0 < FACE_COUNT {
        for i: 0..FACE_COUNT - 1 {
            if is_face_ignored(mesh, i) {
                continue;
            }
            for j: 0..cast(u32) 3 - 1 {
                EDGE := (i * 3) + j;
                VERTEX0: u32 = ((cast(**u32) *(index_explicit(*indices, EDGE))).*).*;
                VERTEX1: u32 = ((cast(**u32) *(index_explicit(*indices, (i * 3) + (j + 1) % 3))).*).*;

                OPPOSITE_EDGE := find_edge(mesh, VERTEX1, VERTEX0);
                if OPPOSITE_EDGE != 4294967295 {
                    assignment_39: u32 = OPPOSITE_EDGE;
                    (((cast(**u32) *(index_explicit(*opposite_edges, EDGE))).*).*) = assignment_39;
                } else {
                    push_back(*boundary_edges, *EDGE);
                    set(*is_boundary_vertex, VERTEX0);
                    set(*is_boundary_vertex, VERTEX1);
                }
            }
        }
    }
}

find_edge :: (using mesh: *Internal_Mesh, vertex0_2: u32, vertex1_2: u32) -> u32 {
    {
        key_2 := make_edge_key(vertex0_2, vertex1_2);
        edge_3 := get(*edge_map, *key_2);
        while edge_3 != 4294967295 {
            if !is_face_ignored(mesh, internal_mesh_edge_face(edge_3)) {
                return edge_3;
            }
            edge_3 = get_next(*edge_map, *key_2, edge_3);
        }
    }

    if !is_empty(*next_colocal_vertex) {
        colocal_vertex0 := vertex0_2;
        while true {
            colocal_vertex1 := vertex1_2;
            while true {
                key := make_edge_key(colocal_vertex0, colocal_vertex1);
                edge_2 := get(*edge_map, *key);
                while edge_2 != 4294967295 {
                    if !is_face_ignored(mesh, internal_mesh_edge_face(edge_2)) {
                        return edge_2;
                    }
                    edge_2 = get_next(*edge_map, *key, edge_2);
                }
                colocal_vertex1 = ((cast(**u32) *(index_explicit_7(*next_colocal_vertex, colocal_vertex1))).*).*;
                if colocal_vertex1 == vertex1_2 {
                    break;
                }
            }
            colocal_vertex0 = ((cast(**u32) *(index_explicit_7(*next_colocal_vertex, colocal_vertex0))).*).*;
            if colocal_vertex0 == vertex0_2 {
                break;
            }
        }
    }
    return 4294967295;
}

get :: (using hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key)), key: *Edge_Key) -> u32 {
    if slots == null {
        return 4294967295;
    }
    return find(hash_map, key, slots[compute_hash(hash_map, key)]);
}

compute_hash :: (using hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key)), key: *Edge_Key) -> u32 {
    hash: Edge_Hash = ---;
    return call(*hash, key) & (num_slots - 1);
}

call :: (using edge_hash: *Edge_Hash, k: *Edge_Key) -> u32 {
    return k.v0 * 32768 + k.v1;
}

find :: (using hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key)), key: *Edge_Key, current_2: u32) -> u32 {
    equal: Equal(Edge_Key) = ---;
    while current_2 != 4294967295 {
        if call_2(*equal, index_explicit_42(*keys, current_2), key) {
            return current_2;
        }
        current_2 = ((cast(**u32) *(index_explicit_7(*next, current_2))).*).*;
    }
    return current_2;
}

index_explicit_42 :: (using array: *Array(Edge_Key), index: u32) -> *Edge_Key {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Edge_Key) base.buffer)[index];
}

call_2 :: (using equal: *Equal(Edge_Key), k0: *Edge_Key, k1: *Edge_Key) -> bool {
    return equals(k0, k1);
}

equals :: (using edge_key: *Edge_Key, k: *Edge_Key) -> bool {
    return v0 == k.v0 && v1 == k.v1;
}

get_next :: (using hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key)), key: *Edge_Key, current_2: u32) -> u32 {
    return find(hash_map, key, ((cast(**u32) *(index_explicit_7(*next, current_2))).*).*);
}

is_face_ignored :: (using mesh: *Internal_Mesh, face_2: u32) -> bool {
    return flags & INTERNAL_MESH_FLAGS_HAS_IGNORED_FACES != 0 && ((cast(**bool) *(index_explicit_43(*face_ignore, face_2))).*).*;
}

index_explicit_43 :: (using array: *Array(bool), index: u32) -> *bool {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*bool) base.buffer)[index];
}

create_colocals :: (using mesh: *Internal_Mesh) {
    if epsilon <= cast(float32) 1.19209290e-7 {
        create_colocals_hash(mesh);
    } else {
        create_colocals_bvh(mesh);
    }
}

create_colocals_bvh :: (using mesh: *Internal_Mesh) {
    VERTEX_COUNT := size(*positions);
    aabbs: Array(AABB) = ---;
    defer deinit(*aabbs);
    init(*aabbs, cast(s32) INTERNAL_MEM_TAG_BVH);
    resize(*aabbs, VERTEX_COUNT);
    {
        i_2: u32 = 0;
        while i_2 < size(*positions) {
            assign_8(
                index_explicit_45(*aabbs, i_2),
                (ifx true { temporary___g0: AABB = (ifx true {
    temporary_g62: AABB = ---;
    init(*temporary_g62, index_explicit_10(*positions, i_2), epsilon);
    temporary_g62;
})
; *temporary___g0; })
            );
            i_2 += 1;
        }
    }
    bvh: BVH = ---;
    defer deinit(*bvh);
    init(*bvh, *aabbs, 4);
    colocals: Array(u32) = ---;
    defer deinit(*colocals);
    init(*colocals, cast(s32) INTERNAL_MEM_TAG_MESH_COLOCALS);
    potential: Array(u32) = ---;
    defer deinit(*potential);
    init(*potential, cast(s32) INTERNAL_MEM_TAG_MESH_COLOCALS);
    resize(*next_colocal_vertex, VERTEX_COUNT);
    fill_bytes(*next_colocal_vertex, 0xff);
    resize(*first_colocal_vertex, VERTEX_COUNT);
    fill_bytes(*first_colocal_vertex, 0xff);
    {
        i: u32 = 0;
        while i < VERTEX_COUNT {
            if ((cast(**u32) *(index_explicit(*next_colocal_vertex, i))).*).* != 4294967295 {
                i += 1;
                continue;
            }

            clear(*colocals);
            push_back(*colocals, *i);
            query(
                *bvh,
                (ifx true { temporary___g1: AABB = (ifx true {
    temporary_g63: AABB = ---;
    init(*temporary_g63, index_explicit_10(*positions, i), epsilon);
    temporary_g63;
})
; *temporary___g1; }),
                *potential
            );
            {
                j_2: u32 = 0;
                while j_2 < size(*potential) {
                    OTHER_VERTEX: u32 = ((cast(**u32) *(index_explicit(*potential, j_2))).*).*;
                    if OTHER_VERTEX != i &&
                        internal_equal(
                            index_explicit_10(*positions, i),
                            index_explicit_10(*positions, OTHER_VERTEX),
                            epsilon
                        ) &&
                        ((cast(**u32) *(index_explicit(*next_colocal_vertex, OTHER_VERTEX))).*).* == 4294967295 {
                        push_back(*colocals, *OTHER_VERTEX);
                    }
                    j_2 += 1;
                }
            }
            if size(*colocals) == 1 {
                assignment_40: u32 = i;
                (((cast(**u32) *(index_explicit(*next_colocal_vertex, i))).*).*) = assignment_40;
                assignment_41: u32 = i;
                (((cast(**u32) *(index_explicit(*first_colocal_vertex, i))).*).*) = assignment_41;
                i += 1;
                continue;
            }

            internal_insertion_sort(data(*colocals), size(*colocals));
            {
                j: u32 = 0;
                while j < size(*colocals) {
                    assignment_42: u32 = ((cast(**u32) *(index_explicit(*colocals, (j + 1) % size(*colocals)))).*).*;
                    (((cast(**u32) *(index_explicit(*next_colocal_vertex, ((cast(**u32) *(index_explicit(*colocals, j))).*).*))).*).*) = assignment_42;
                    assignment_43: u32 = ((cast(**u32) *(index_explicit(*colocals, 0))).*).*;
                    (((cast(**u32) *(index_explicit(*first_colocal_vertex, ((cast(**u32) *(index_explicit(*colocals, j))).*).*))).*).*) = assignment_43;
                    j += 1;
                }
            }
            assert(((cast(**u32) *(index_explicit(*next_colocal_vertex, i))).*).* != 4294967295);
            i += 1;
        }
    }
}

internal_equal :: (v0: *Vector3, v1: *Vector3, epsilon_2: float32) -> bool {
    return std_fabs(v0.x - v1.x) <= epsilon_2 && std_fabs(v0.y - v1.y) <= epsilon_2 && std_fabs(v0.z - v1.z) <= epsilon_2;
}

query :: (using bvh: *BVH, query_aabb: *AABB, result: *Array(u32)) {
    clear(result);

    todo: [64] u32 = ---;
    stackptr: s32 = 0;

    todo[stackptr] = 0;
    while stackptr >= 0 {
        NI := cast,no_check(s32) (todo[c_transpiler_post_decrement(*(stackptr))]);
        node: *BVH_Node = cast,no_check(*BVH_Node) index_explicit_44(*nodes, cast,no_check(u32) NI);

        if node.right_offset == 0 {
            {
                o: u32 = 0;
                while o < node.n_prims {
                    OBJ := node.start + o;
                    if intersect(
                        query_aabb,
                        index_explicit_15(object_aabbs, ((cast(**u32) *(index_explicit_7(*object_ids, OBJ))).*).*)
                    ) {
                        push_back(result, index_explicit_7(*object_ids, OBJ));
                    }
                    o += 1;
                }
            }
        } else {
            LEFT := cast,no_check(u32) (NI + 1);
            RIGHT := (cast,no_check(u32) NI) + node.right_offset;
            if intersect(query_aabb, *((index_explicit_44(*nodes, LEFT)).aabb)) {
                assignment_44: u32 = LEFT;
                (todo[c_transpiler_pre_increment(*(stackptr))]) = assignment_44;
            }
            if intersect(query_aabb, *((index_explicit_44(*nodes, RIGHT)).aabb)) {
                assignment_45: u32 = RIGHT;
                (todo[c_transpiler_pre_increment(*(stackptr))]) = assignment_45;
            }
        }
    }
}

index_explicit_44 :: (using array: *Array(BVH_Node), index: u32) -> *BVH_Node {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*BVH_Node) base.buffer)[index];
}

intersect :: (using aabb: *AABB, other: *AABB) -> bool {
    return min.x <= other.max.x && max.x >= other.min.x && min.y <= other.max.y && max.y >= other.min.y && min.z <= other.max.z && max.z >= other.min.z;
}

fill_bytes :: (using array: *Array(u32), value: u8) {
    if base.buffer != null && base.size > 0 {
        fill_memory(base.buffer, cast,no_check(s32) value, cast,no_check(u64) (base.size * base.element_size));
    }
}

index_explicit_45 :: (using array: *Array(AABB), index: u32) -> *AABB {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*AABB) base.buffer)[index];
}

assign_8 :: inline (using aabb: *AABB, unnamed_39871: *AABB) -> *AABB {
    aabb.* = ((cast(**AABB) *(unnamed_39871)).*).*;
    return (cast(**AABB) *(aabb)).*;
}

assign_9 :: inline (using vector3: *Vector3, unnamed_39887: *Vector3) -> *Vector3 {
    vector3.* = ((cast(**Vector3) *(unnamed_39887)).*).*;
    return (cast(**Vector3) *(vector3)).*;
}

resize :: (using array: *Array(AABB), new_size: u32) {
    resize(*base, new_size, true);
}

create_colocals_hash :: (using mesh: *Internal_Mesh) {
    VERTEX_COUNT := size(*positions);
    position_to_vertex_map: Hash_Map(Vector3, Hash(Vector3), Equal(Vector3)) = ---;
    defer deinit(*position_to_vertex_map);
    init(*position_to_vertex_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT, VERTEX_COUNT);
    if 0 < VERTEX_COUNT {
        for i_2: 0..VERTEX_COUNT - 1 {
            add(*position_to_vertex_map, index_explicit_10(*positions, i_2));
        }
    }
    colocals: Array(u32) = ---;
    defer deinit(*colocals);
    init(*colocals, cast(s32) INTERNAL_MEM_TAG_MESH_COLOCALS);
    resize(*next_colocal_vertex, VERTEX_COUNT);
    fill_bytes(*next_colocal_vertex, 0xff);
    resize(*first_colocal_vertex, VERTEX_COUNT);
    fill_bytes(*first_colocal_vertex, 0xff);
    {
        i: u32 = 0;
        while i < VERTEX_COUNT {
            if ((cast(**u32) *(index_explicit(*next_colocal_vertex, i))).*).* != 4294967295 {
                i += 1;
                continue;
            }

            clear(*colocals);
            push_back(*colocals, *i);
            other_vertex := get(*position_to_vertex_map, index_explicit_10(*positions, i));
            while other_vertex != 4294967295 {
                if other_vertex != i &&
                    internal_equal(index_explicit_10(*positions, i), index_explicit_10(*positions, other_vertex), epsilon) &&
                    ((cast(**u32) *(index_explicit(*next_colocal_vertex, other_vertex))).*).* == 4294967295 {
                    push_back(*colocals, *other_vertex);
                }
                other_vertex = get_next(*position_to_vertex_map, index_explicit_10(*positions, i), other_vertex);
            }
            if size(*colocals) == 1 {
                assignment_46: u32 = i;
                (((cast(**u32) *(index_explicit(*next_colocal_vertex, i))).*).*) = assignment_46;
                assignment_47: u32 = i;
                (((cast(**u32) *(index_explicit(*first_colocal_vertex, i))).*).*) = assignment_47;
                i += 1;
                continue;
            }

            internal_insertion_sort(data(*colocals), size(*colocals));
            {
                j: u32 = 0;
                while j < size(*colocals) {
                    assignment_48: u32 = ((cast(**u32) *(index_explicit(*colocals, (j + 1) % size(*colocals)))).*).*;
                    (((cast(**u32) *(index_explicit(*next_colocal_vertex, ((cast(**u32) *(index_explicit(*colocals, j))).*).*))).*).*) = assignment_48;
                    assignment_49: u32 = ((cast(**u32) *(index_explicit(*colocals, 0))).*).*;
                    (((cast(**u32) *(index_explicit(*first_colocal_vertex, ((cast(**u32) *(index_explicit(*colocals, j))).*).*))).*).*) = assignment_49;
                    j += 1;
                }
            }
            assert(((cast(**u32) *(index_explicit(*next_colocal_vertex, i))).*).* != 4294967295);
            i += 1;
        }
    }
}

get :: (using hash_map: *Hash_Map(Vector3, Hash(Vector3), Equal(Vector3)), key: *Vector3) -> u32 {
    if slots == null {
        return 4294967295;
    }
    return find(hash_map, key, slots[compute_hash(hash_map, key)]);
}

compute_hash :: (using hash_map: *Hash_Map(Vector3, Hash(Vector3), Equal(Vector3)), key: *Vector3) -> u32 {
    hash: Hash(Vector3) = ---;
    return call_3(*hash, key) & (num_slots - 1);
}

call_3 :: (using hash: *Hash(Vector3), k: *Vector3) -> u32 {
    return internal_hash(k, 5381);
}

internal_hash :: (t: *Vector3, h: u32) -> u32 {
    return internal_sdbm_hash(cast(*void) ((cast(**Vector3) *(t)).*), 12, h);
}

internal_sdbm_hash :: (data_in: *void, size_3: u32, h: u32) -> u32 {
    data_40 := cast(*u8) data_in;
    i: u32 = 0;
    while i < size_3 {
        h = h << 16 + h << 6 - h + cast,no_check(u32) (data_40[c_transpiler_post_increment(*(i))]);
    }
    return h;
}

find :: (using hash_map: *Hash_Map(Vector3, Hash(Vector3), Equal(Vector3)), key: *Vector3, current_2: u32) -> u32 {
    equal: Equal(Vector3) = ---;
    while current_2 != 4294967295 {
        if call_4(*equal, index_explicit_9(*keys, current_2), key) {
            return current_2;
        }
        current_2 = ((cast(**u32) *(index_explicit_7(*next, current_2))).*).*;
    }
    return current_2;
}

call_4 :: (using equal: *Equal(Vector3), k0: *Vector3, k1: *Vector3) -> bool {
    return equals_in_xatlas(k0, k1);
}

equals_in_xatlas :: (a: *Vector3, b: *Vector3) -> bool {
    return a.x == b.x && a.y == b.y && a.z == b.z;
}

get_next :: (using hash_map: *Hash_Map(Vector3, Hash(Vector3), Equal(Vector3)), key: *Vector3, current_2: u32) -> u32 {
    return find(hash_map, key, ((cast(**u32) *(index_explicit_7(*next, current_2))).*).*);
}

add :: (hash_map: *Hash_Map(Vector3, Hash(Vector3), Equal(Vector3)), key: *Vector3) -> u32 {
    if hash_map.slots == null {
        alloc(hash_map);
    }
    HASH := compute_hash(hash_map, key);
    push_back(*hash_map.keys, key);
    push_back(*hash_map.next, *hash_map.slots[HASH]);
    hash_map.slots[HASH] = size(*hash_map.next) - 1;
    return size(*hash_map.keys) - 1;
}

push_back :: (using array: *Array(Vector3), value: *Vector3) {
    push_back(*base, cast(*u8) ((cast(**Vector3) *(value)).*));
}

alloc :: (using hash_map: *Hash_Map(Vector3, Hash(Vector3), Equal(Vector3))) {
    assert(size > 0);
    num_slots = internal_next_power_of_two(size);
    min_num_slots := cast,no_check(u32) (size * 1.3);
    if num_slots < min_num_slots {
        num_slots = internal_next_power_of_two(min_num_slots);
    }
    slots =
        cast(*u32) internal_realloc(
            null,
            4 * cast(u64) num_slots,
            mem_tag,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1995
        );
    {
        i: u32 = 0;
        while i < num_slots {
            slots[i] = 4294967295;
            i += 1;
        }
    }
    reserve(*keys, size);
    reserve(*next, size);
}

reserve :: (using array: *Array(Vector3), desired_size: u32) {
    reserve(*base, desired_size);
}

add_face :: (using mesh: *Internal_Mesh, _indices: *u32, ignore: bool, material: u32) {
    if flags & INTERNAL_MESH_FLAGS_HAS_IGNORED_FACES != 0 {
        push_back(*face_ignore, *ignore);
    }
    if flags & INTERNAL_MESH_FLAGS_HAS_MATERIALS != 0 {
        push_back(*face_materials, *material);
    }
    FIRST_INDEX := size(*indices);
    for i_2: 0..cast(u32) 3 - 1 {
        push_back(*indices, *_indices[i_2]);
    }
    for i: 0..cast(u32) 3 - 1 {
        VERTEX0: u32 = ((cast(**u32) *(index_explicit(*indices, FIRST_INDEX + i))).*).*;
        VERTEX1: u32 = ((cast(**u32) *(index_explicit(*indices, FIRST_INDEX + (i + 1) % 3))).*).*;
        add(*edge_map, (ifx true { temporary___g0: Edge_Key = make_edge_key(VERTEX0, VERTEX1); *temporary___g0; }));
    }
}

add :: (hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key)), key: *Edge_Key) -> u32 {
    if hash_map.slots == null {
        alloc(hash_map);
    }
    HASH := compute_hash(hash_map, key);
    push_back(*hash_map.keys, key);
    push_back(*hash_map.next, *hash_map.slots[HASH]);
    hash_map.slots[HASH] = size(*hash_map.next) - 1;
    return size(*hash_map.keys) - 1;
}

size :: (using array: *Array(Edge_Key)) -> u32 {
    return base.size;
}

push_back :: (using array: *Array(Edge_Key), value: *Edge_Key) {
    push_back(*base, cast(*u8) ((cast(**Edge_Key) *(value)).*));
}

alloc :: (using hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key))) {
    assert(size > 0);
    num_slots = internal_next_power_of_two(size);
    min_num_slots := cast,no_check(u32) (size * 1.3);
    if num_slots < min_num_slots {
        num_slots = internal_next_power_of_two(min_num_slots);
    }
    slots =
        cast(*u32) internal_realloc(
            null,
            4 * cast(u64) num_slots,
            mem_tag,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1995
        );
    {
        i: u32 = 0;
        while i < num_slots {
            slots[i] = 4294967295;
            i += 1;
        }
    }
    reserve(*keys, size);
    reserve(*next, size);
}

reserve :: (using array: *Array(Edge_Key), desired_size: u32) {
    reserve(*base, desired_size);
}

push_back :: (using array: *Array(bool), value: *bool) {
    push_back(*base, cast(*u8) ((cast(**bool) *(value)).*));
}

get :: (using hash_map: *Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)), key: *u32) -> u32 {
    if slots == null {
        return 4294967295;
    }
    return find(hash_map, key, slots[compute_hash(hash_map, key)]);
}

compute_hash :: (using hash_map: *Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)), key: *u32) -> u32 {
    hash: Passthrough_Hash(u32) = ---;
    return call_5(*hash, key) & (num_slots - 1);
}

call_5 :: (using passthrough_hash: *Passthrough_Hash(u32), k: *u32) -> u32 {
    return k.*;
}

find :: (using hash_map: *Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)), key: *u32, current_2: u32) -> u32 {
    equal: Equal(u32) = ---;
    while current_2 != 4294967295 {
        if call_6(*equal, index_explicit_7(*keys, current_2), key) {
            return current_2;
        }
        current_2 = ((cast(**u32) *(index_explicit_7(*next, current_2))).*).*;
    }
    return current_2;
}

call_6 :: (using equal: *Equal(u32), k0: *u32, k1: *u32) -> bool {
    return k0.* == k1.*;
}

add_vertex :: (using mesh: *Internal_Mesh, pos: *Vector3, normal_2: *Vector3, texcoord_3: *Vector2) {
    assert(internal_is_finite(pos));
    push_back(*positions, pos);
    if flags & INTERNAL_MESH_FLAGS_HAS_NORMALS != 0 {
        push_back(*normals, normal_2);
    }
    push_back(*texcoords, texcoord_3);
}

internal_is_finite :: (v: *Vector3) -> bool {
    return internal_is_finite(v.x) && internal_is_finite(v.y) && internal_is_finite(v.z);
}

normal :: (using mesh: *Internal_Mesh, vertex: u32) -> *Vector3 {
    assert(flags & INTERNAL_MESH_FLAGS_HAS_NORMALS != 0);
    return index_explicit_9(*normals, vertex);
}

flags :: (using mesh: *Internal_Mesh) -> u32 {
    return flags;
}

add :: (hash_map: *Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)), key: *u32) -> u32 {
    if hash_map.slots == null {
        alloc(hash_map);
    }
    HASH := compute_hash(hash_map, key);
    push_back(*hash_map.keys, key);
    push_back(*hash_map.next, *hash_map.slots[HASH]);
    hash_map.slots[HASH] = size(*hash_map.next) - 1;
    return size(*hash_map.keys) - 1;
}

alloc :: (using hash_map: *Hash_Map(u32, Passthrough_Hash(u32), Equal(u32))) {
    assert(size > 0);
    num_slots = internal_next_power_of_two(size);
    min_num_slots := cast,no_check(u32) (size * 1.3);
    if num_slots < min_num_slots {
        num_slots = internal_next_power_of_two(min_num_slots);
    }
    slots =
        cast(*u32) internal_realloc(
            null,
            4 * cast(u64) num_slots,
            mem_tag,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1995
        );
    {
        i: u32 = 0;
        while i < num_slots {
            slots[i] = 4294967295;
            i += 1;
        }
    }
    reserve(*keys, size);
    reserve(*next, size);
}

face :: (using iterator: *Mesh_Face_Groups_Iterator) -> u32 {
    return current;
}

advance :: (using iterator: *Mesh_Face_Groups_Iterator) {
    current = ((cast(**u32) *(index_explicit_7(*mesh_face_groups.next_face, current))).*).*;
}

is_done :: (using iterator: *Mesh_Face_Groups_Iterator) -> bool {
    return current == 4294967295;
}

face_count :: (using mesh_face_groups: *Mesh_Face_Groups, group: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*face_count, group))).*).*;
}

face_count :: (using chart_group: *Chart_Group) -> u32 {
    return face_count(source_mesh_face_groups, face_group);
}

compute :: (using atlas: *Segment_Atlas) {
    if data.options.use_input_mesh_uvs {
        compute(*original_uv_charts);
    }

    compute(*planar_charts);

    compute(*clustered_charts);
}

compute :: (using clustered_charts: *Clustered_Charts) {
    FACE_COUNT := face_count(data.mesh);
    faces_left = 0;
    if 0 < FACE_COUNT {
        for i_2: 0..FACE_COUNT - 1 {
            if !get(*data.is_face_in_chart, i_2) {
                faces_left += 1;
            }
        }
    }
    CHART_COUNT := size(*charts);
    if 0 < CHART_COUNT {
        for i: 0..CHART_COUNT - 1 {
            deinit((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, i)).*);
            internal_realloc(
                cast(*void) ((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, i)).*),
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                5346
            );
        }
    }
    clear(*charts);
    resize(*face_charts, FACE_COUNT);
    fill(*face_charts, (ifx true { temporary___g0: s32 = -cast(s32) 1; *temporary___g0; }));
    resize(*texcoords, FACE_COUNT * 3);
    if faces_left == 0 {
        return;
    }

    place_seeds(clustered_charts, data.options.max_cost * 0.5);
    if data.options.max_iterations == 0 {
        assert(faces_left == 0);
        return;
    }
    relocate_seeds(clustered_charts);
    reset_charts(clustered_charts);

    iteration: u32 = 0;
    while true {
        grow_charts(clustered_charts, data.options.max_cost);

        fill_holes(clustered_charts, data.options.max_cost * 0.5);

        merge_charts(clustered_charts);

        if c_transpiler_pre_increment(*(iteration)) == data.options.max_iterations {
            break;
        }
        if !relocate_seeds(clustered_charts) {
            break;
        }
        reset_charts(clustered_charts);
    }

    assert(faces_left == 0);
}

reset_charts :: (using clustered_charts: *Clustered_Charts) {
    FACE_COUNT := face_count(data.mesh);
    if 0 < FACE_COUNT {
        for i_3: 0..FACE_COUNT - 1 {
            if ((cast(**s32) *(index_explicit_48(*face_charts, i_3))).*).* != -1 {
                unset(*data.is_face_in_chart, i_3);
            }
            assignment_50: s32 = -1;
            (((cast(**s32) *(index_explicit_48(*face_charts, i_3))).*).*) = assignment_50;
        }
    }
    faces_left = 0;
    if 0 < FACE_COUNT {
        for i_2: 0..FACE_COUNT - 1 {
            if !get(*data.is_face_in_chart, i_2) {
                faces_left += 1;
            }
        }
    }
    CHART_COUNT := size(*charts);
    if 0 < CHART_COUNT {
        for i: 0..CHART_COUNT - 1 {
            chart: *Clustered_Charts_Chart =
                cast,no_check(*Clustered_Charts_Chart) ((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, i)).*);
            chart.area = 0.0;
            chart.boundary_length = 0.0;
            assign_9(*chart.basis.normal, (ifx true { temporary___g0: Vector3 = make_vector3(0.0); *temporary___g0; }));
            assign_9(*chart.basis.tangent, (ifx true { temporary___g1: Vector3 = make_vector3(0.0); *temporary___g1; }));
            assign_9(*chart.basis.bitangent, (ifx true { temporary___g2: Vector3 = make_vector3(0.0); *temporary___g2; }));
            assign_9(*chart.centroid_sum, (ifx true { temporary___g4: Vector3 = make_vector3(0.0); *temporary___g4; }));
            assign_9(*chart.centroid, (ifx true { temporary___g3: Vector3 = make_vector3(0.0); *temporary___g3; }));
            clear(*chart.faces);
            clear(*chart.candidates);
            clear(*chart.failed_planar_regions);
            add_face_to_chart(clustered_charts, chart, chart.seed);
        }
    }
}

add_face_to_chart :: (using clustered_charts: *Clustered_Charts, chart: *Clustered_Charts_Chart, face_2: u32) -> bool {
    assert(!get(*data.is_face_in_chart, face_2));
    OLD_FACE_COUNT := size(*chart.faces);
    FIRST_FACE := OLD_FACE_COUNT == 0;

    push_back(*chart.faces, *face_2);
    coplanar_face := next_region_face(planar_charts, face_2);
    while coplanar_face != face_2 {
        assert(!get(*data.is_face_in_chart, coplanar_face));
        push_back(*chart.faces, *coplanar_face);
        coplanar_face = next_region_face(planar_charts, coplanar_face);
    }
    FACE_COUNT := size(*chart.faces);

    basis: Basis = ---;
    init(*basis);
    if FIRST_FACE {
        assign_7(*basis.normal, index_explicit_10(*data.face_normals, face_2));
        assign_9(
            *basis.tangent,
            (ifx true { temporary___g1: Vector3 = internal_normalize(
            (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(
            position(data.mesh, vertex_at(data.mesh, (face_2 * 3) + 0)),
            position(data.mesh, vertex_at(data.mesh, (face_2 * 3) + 1))
        ); *temporary___g0; })
        ); *temporary___g1; })
        );
        assign_9(
            *basis.bitangent,
            (ifx true { temporary___g2: Vector3 = internal_cross(*basis.normal, *basis.tangent); *temporary___g2; })
        );
    } else {
        if !compute_chart_basis(clustered_charts, chart, *basis) {
            resize(*chart.faces, OLD_FACE_COUNT);
            return false;
        }
        if internal_dot(*basis.normal, index_explicit_10(*data.face_normals, face_2)) < 0.0 {
            assign_9(*basis.normal, (ifx true { temporary___g4: Vector3 = subtract(*basis.normal); *temporary___g4; }));
        }
    }
    if !FIRST_FACE {
        parameterize_chart(clustered_charts, chart);
        {
            i_4 := OLD_FACE_COUNT;
            while i_4 < FACE_COUNT {
                assignment_51: s32 = chart.id;
                (((cast(**s32) *(index_explicit_48(*face_charts, ((cast(**u32) *(index_explicit(*chart.faces, i_4))).*).*))).*).*) = assignment_51;
                i_4 += 1;
            }
        }
        if !is_chart_parameterization_valid(clustered_charts, chart) {
            {
                i_3 := OLD_FACE_COUNT;
                while i_3 < FACE_COUNT {
                    assignment_52: s32 = -1;
                    (((cast(**s32) *(index_explicit_48(*face_charts, ((cast(**u32) *(index_explicit(*chart.faces, i_3))).*).*))).*).*) = assignment_52;
                    i_3 += 1;
                }
            }
            resize(*chart.faces, OLD_FACE_COUNT);
            return false;
        }
    }

    chart.basis = basis;
    chart.area = compute_area(clustered_charts, chart, face_2);
    chart.boundary_length = compute_boundary_length(clustered_charts, chart, face_2);
    {
        i_2 := OLD_FACE_COUNT;
        while i_2 < FACE_COUNT {
            F_2: u32 = ((cast(**u32) *(index_explicit(*chart.faces, i_2))).*).*;
            assignment_53: s32 = chart.id;
            (((cast(**s32) *(index_explicit_48(*face_charts, F_2))).*).*) = assignment_53;
            faces_left -= 1;
            set(*data.is_face_in_chart, F_2);
            add_assign(
                *chart.centroid_sum,
                (ifx true { temporary___g3: Vector3 = compute_face_center(data.mesh, F_2); *temporary___g3; })
            );
            i_2 += 1;
        }
    }
    assign_9(
        *chart.centroid,
        (ifx true { temporary___g6: Vector3 = internal_operator_in_xatlas(*chart.centroid_sum, cast,no_check(float32) size(*chart.faces)); *temporary___g6; })
    );

    clear(*chart.candidates);
    if 0 < FACE_COUNT {
        for i: 0..FACE_COUNT - 1 {
            F: u32 = ((cast(**u32) *(index_explicit(*chart.faces, i))).*).*;
            for j: 0..cast(u32) 3 - 1 {
                EDGE := (F * 3) + j;
                OEDGE := opposite_edge(data.mesh, EDGE);
                if OEDGE == 4294967295 {
                    continue;
                }
                OFACE := internal_mesh_edge_face(OEDGE);
                if get(*data.is_face_in_chart, OFACE) {
                    continue;
                }
                if contains(
                    *chart.failed_planar_regions,
                    (ifx true { temporary___g5: u32 = region_id_from_face(planar_charts, OFACE); *temporary___g5; })
                ) {
                    continue;
                }
                COST := compute_cost(clustered_charts, chart, OFACE);
                if COST < cast(float32) 3.40282347e+38 {
                    push(*chart.candidates, COST, OFACE);
                }
            }
        }
    }
    return true;
}

opposite_edge :: (using mesh: *Internal_Mesh, edge_2: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*opposite_edges, edge_2))).*).*;
}

compute_cost :: (using clustered_charts: *Clustered_Charts, chart: *Clustered_Charts_Chart, face_2: u32) -> float32 {
    NEW_CHART_AREA := compute_area(clustered_charts, chart, face_2);
    NEW_BOUNDARY_LENGTH := compute_boundary_length(clustered_charts, chart, face_2);

    if data.options.max_chart_area > 0.0 && NEW_CHART_AREA > data.options.max_chart_area {
        return cast(float32) 3.40282347e+38;
    }
    if data.options.max_boundary_length > 0.0 && NEW_BOUNDARY_LENGTH > data.options.max_boundary_length {
        return cast(float32) 3.40282347e+38;
    }

    cost: float32 = 0.0;
    NORMAL_DEVIATION := compute_normal_deviation_metric(clustered_charts, chart, face_2);
    if NORMAL_DEVIATION >= 0.707 {
        return cast(float32) 3.40282347e+38;
    }
    cost += data.options.normal_deviation_weight * NORMAL_DEVIATION;

    NORMAL_SEAM := compute_normal_seam_metric(clustered_charts, chart, face_2);
    if data.options.normal_seam_weight >= 1000.0 && NORMAL_SEAM > 0.0 {
        return cast(float32) 3.40282347e+38;
    }
    cost += data.options.normal_seam_weight * NORMAL_SEAM;
    cost +=
        data.options.roundness_weight *
            compute_roundness_metric(clustered_charts, chart, NEW_BOUNDARY_LENGTH, NEW_CHART_AREA);
    cost += data.options.straightness_weight * compute_straightness_metric(clustered_charts, chart, face_2);
    cost += data.options.texture_seam_weight * compute_texture_seam_metric(clustered_charts, chart, face_2);

    assert(internal_is_finite(cost));
    return cost;
}

compute_texture_seam_metric :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    first_face: u32
) -> float32 {
    seam_length: float32 = 0.0;
    total_length: float32 = 0.0;
    face_2 := first_face;
    while true {
        {
            it_: Mesh_Face_Edge_Iterator = ---;
            init(*it_, data.mesh, face_2);
            while !is_done(*it_) {
                if is_boundary(*it_) {
                    advance(*it_);
                    continue;
                }
                if ((cast(**s32) *(index_explicit_46(*face_charts, opposite_face(*it_)))).*).* != chart.id {
                    advance(*it_);
                    continue;
                }
                l := ((cast(**float32) *(index_explicit_26(*data.edge_lengths, edge(*it_)))).*).*;
                total_length += l;
                if !is_seam(*it_) {
                    advance(*it_);
                    continue;
                }

                if is_texture_seam(*it_) {
                    seam_length += l;
                }
                advance(*it_);
            }
        }
        face_2 = next_region_face(planar_charts, face_2);
        if face_2 == first_face {
            break;
        }
    }
    if seam_length <= 0.0 {
        return 0.0;
    }
    return seam_length / total_length;
}

next_region_face :: (using planar_charts: *Planar_Charts, face_2: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*next_region_face, face_2))).*).*;
}

is_texture_seam :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> bool {
    return is_texture_seam(mesh, edge);
}

is_texture_seam :: (using mesh: *Internal_Mesh, edge_2: u32) -> bool {
    OPPOSITE_EDGE: u32 = ((cast(**u32) *(index_explicit_7(*opposite_edges, edge_2))).*).*;
    if OPPOSITE_EDGE == 4294967295 {
        return false;
    }
    E0 := internal_mesh_edge_index0(edge_2);
    E1 := internal_mesh_edge_index1(edge_2);
    OE0 := internal_mesh_edge_index0(OPPOSITE_EDGE);
    OE1 := internal_mesh_edge_index1(OPPOSITE_EDGE);
    return not_equal(
        index_explicit_18(*texcoords, ((cast(**u32) *(index_explicit_7(*indices, E0))).*).*),
        index_explicit_18(*texcoords, ((cast(**u32) *(index_explicit_7(*indices, OE1))).*).*)
    ) || not_equal(
        index_explicit_18(*texcoords, ((cast(**u32) *(index_explicit_7(*indices, E1))).*).*),
        index_explicit_18(*texcoords, ((cast(**u32) *(index_explicit_7(*indices, OE0))).*).*)
    );
}

not_equal :: (a: *Vector2, b: *Vector2) -> bool {
    return a.x != b.x || a.y != b.y;
}

is_seam :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> bool {
    return is_seam(mesh, edge);
}

is_seam :: (using mesh: *Internal_Mesh, edge_2: u32) -> bool {
    OPPOSITE_EDGE: u32 = ((cast(**u32) *(index_explicit_7(*opposite_edges, edge_2))).*).*;
    if OPPOSITE_EDGE == 4294967295 {
        return false;
    }
    E0 := internal_mesh_edge_index0(edge_2);
    E1 := internal_mesh_edge_index1(edge_2);
    OE0 := internal_mesh_edge_index0(OPPOSITE_EDGE);
    OE1 := internal_mesh_edge_index1(OPPOSITE_EDGE);
    return ((cast(**u32) *(index_explicit_7(*indices, E0))).*).* != ((cast(**u32) *(index_explicit_7(*indices, OE1))).*).* || ((cast(**u32) *(index_explicit_7(*indices, E1))).*).* != ((cast(**u32) *(index_explicit_7(*indices, OE0))).*).*;
}

index_explicit_46 :: (using array: *Array(s32), index: u32) -> *s32 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*s32) base.buffer)[index];
}

is_boundary :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> bool {
    return ((cast(**u32) *(index_explicit_7(*mesh.opposite_edges, edge))).*).* == 4294967295;
}

compute_straightness_metric :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    first_face: u32
) -> float32 {
    l_out: float32 = 0.0;
    l_in: float32 = 0.0;
    PLANAR_REGION_ID := region_id_from_face(planar_charts, first_face);
    face_2 := first_face;
    while true {
        {
            it_: Mesh_Face_Edge_Iterator = ---;
            init(*it_, data.mesh, face_2);
            while !is_done(*it_) {
                L := ((cast(**float32) *(index_explicit_26(*data.edge_lengths, edge(*it_)))).*).*;
                if is_boundary(*it_) {
                    l_out += L;
                } else if region_id_from_face(planar_charts, opposite_face(*it_)) != PLANAR_REGION_ID {
                    if ((cast(**s32) *(index_explicit_46(*face_charts, opposite_face(*it_)))).*).* != chart.id {
                        l_out += L;
                    } else {
                        l_in += L;
                    }
                }
                advance(*it_);
            }
        }
        face_2 = next_region_face(planar_charts, face_2);
        if face_2 == first_face {
            break;
        }
    }

    ratio := (l_out - l_in) / (l_out + l_in);
    return internal_min(*ratio, (ifx true { temporary___g0: float32 = 0.0; *temporary___g0; }));
}

region_id_from_face :: (using planar_charts: *Planar_Charts, face_2: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*face_to_region_id, face_2))).*).*;
}

compute_area :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    first_face: u32
) -> float32 {
    area_2 := chart.area;
    face_2 := first_face;
    while true {
        area_2 += ((cast(**float32) *(index_explicit_26(*data.face_areas, face_2))).*).*;
        face_2 = next_region_face(planar_charts, face_2);
        if face_2 == first_face {
            break;
        }
    }
    return area_2;
}

compute_boundary_length :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    first_face: u32
) -> float32 {
    boundary_length := chart.boundary_length;

    PLANAR_REGION_ID := region_id_from_face(planar_charts, first_face);
    face_2 := first_face;
    while true {
        {
            it_: Mesh_Face_Edge_Iterator = ---;
            init(*it_, data.mesh, face_2);
            while !is_done(*it_) {
                EDGE_LENGTH := ((cast(**float32) *(index_explicit_26(*data.edge_lengths, edge(*it_)))).*).*;
                if is_boundary(*it_) {
                    boundary_length += EDGE_LENGTH;
                } else if region_id_from_face(planar_charts, opposite_face(*it_)) != PLANAR_REGION_ID {
                    if ((cast(**s32) *(index_explicit_46(*face_charts, opposite_face(*it_)))).*).* != chart.id {
                        boundary_length += EDGE_LENGTH;
                    } else {
                        boundary_length -= EDGE_LENGTH;
                    }
                }
                advance(*it_);
            }
        }
        face_2 = next_region_face(planar_charts, face_2);
        if face_2 == first_face {
            break;
        }
    }
    return internal_max((ifx true { temporary___g0: float32 = 0.0; *temporary___g0; }), *boundary_length);
}

compute_roundness_metric :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    new_boundary_length: float32,
    new_chart_area: float32
) -> float32 {
    OLD_ROUNDNESS := internal_square(chart.boundary_length) / chart.area;
    NEW_ROUNDNESS := internal_square(new_boundary_length) / new_chart_area;
    return 1.0 - OLD_ROUNDNESS / NEW_ROUNDNESS;
}

compute_normal_seam_metric :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    first_face: u32
) -> float32 {
    seam_factor: float32 = 0.0;
    total_length: float32 = 0.0;
    face_2 := first_face;
    while true {
        {
            it_: Mesh_Face_Edge_Iterator = ---;
            init(*it_, data.mesh, face_2);
            while !is_done(*it_) {
                if is_boundary(*it_) {
                    advance(*it_);
                    continue;
                }
                if ((cast(**s32) *(index_explicit_46(*face_charts, opposite_face(*it_)))).*).* != chart.id {
                    advance(*it_);
                    continue;
                }
                l := ((cast(**float32) *(index_explicit_26(*data.edge_lengths, edge(*it_)))).*).*;
                total_length += l;
                if !is_seam(*it_) {
                    advance(*it_);
                    continue;
                }

                if is_normal_seam(clustered_charts, edge(*it_)) {
                    d: float32 = ---;
                    if flags(data.mesh) & INTERNAL_MESH_FLAGS_HAS_NORMALS != 0 {
                        n0: *Vector3 = cast,no_check(*Vector3) normal(data.mesh, vertex0(*it_));
                        n1: *Vector3 = cast,no_check(*Vector3) normal(data.mesh, vertex1(*it_));
                        on0: *Vector3 =
                            cast,no_check(*Vector3) normal(
                                data.mesh,
                                vertex_at(
                                data.mesh,
                                internal_mesh_edge_index0(opposite_edge(*it_))
                            )
                            );
                        on1: *Vector3 =
                            cast,no_check(*Vector3) normal(
                                data.mesh,
                                vertex_at(
                                data.mesh,
                                internal_mesh_edge_index1(opposite_edge(*it_))
                            )
                            );
                        D0 :=
                            internal_clamp(
                                (ifx true { temporary___g0: float32 = internal_dot(n0, on1); *temporary___g0; }),
                                (ifx true { temporary___g1: float32 = 0.0; *temporary___g1; }),
                                (ifx true { temporary___g2: float32 = 1.0; *temporary___g2; })
                            );
                        D1 :=
                            internal_clamp(
                                (ifx true { temporary___g4: float32 = internal_dot(n1, on0); *temporary___g4; }),
                                (ifx true { temporary___g3: float32 = 0.0; *temporary___g3; }),
                                (ifx true { temporary___g6: float32 = 1.0; *temporary___g6; })
                            );
                        d = (D0 + D1) * 0.5;
                    } else {
                        (ifx true { assignment_54: float32 = cast,no_check(float32) (internal_clamp(
                            (ifx true { temporary___g5: float32 = internal_dot(
                            index_explicit_10(*data.face_normals, face_2),
                            index_explicit_10(*data.face_normals, internal_mesh_edge_face(opposite_edge(*it_)))
                        ); *temporary___g5; }),
                            (ifx true { temporary___g8: float32 = 0.0; *temporary___g8; }),
                            (ifx true { temporary___g7: float32 = 1.0; *temporary___g7; })
                        )); (d) = assignment_54; assignment_54; });
                    }
                    l *= (cast(s32) 1) - d;
                    seam_factor += l;
                }
                advance(*it_);
            }
        }
        face_2 = next_region_face(planar_charts, face_2);
        if face_2 == first_face {
            break;
        }
    }
    if seam_factor <= 0.0 {
        return 0.0;
    }
    return seam_factor / total_length;
}

is_normal_seam :: (using clustered_charts: *Clustered_Charts, edge_2: u32) -> bool {
    OPPOSITE_EDGE := opposite_edge(data.mesh, edge_2);
    if OPPOSITE_EDGE == 4294967295 {
        return false;
    }
    if flags(data.mesh) & INTERNAL_MESH_FLAGS_HAS_NORMALS != 0 {
        V0 := vertex_at(data.mesh, internal_mesh_edge_index0(edge_2));
        V1 := vertex_at(data.mesh, internal_mesh_edge_index1(edge_2));
        OV0 := vertex_at(data.mesh, internal_mesh_edge_index0(OPPOSITE_EDGE));
        OV1 := vertex_at(data.mesh, internal_mesh_edge_index1(OPPOSITE_EDGE));
        if V0 == OV1 && V1 == OV0 {
            return false;
        }
        return !internal_equal(normal(data.mesh, V0), normal(data.mesh, OV1), K_NORMAL_EPSILON) || !internal_equal(normal(data.mesh, V1), normal(data.mesh, OV0), K_NORMAL_EPSILON);
    }
    F0 := internal_mesh_edge_face(edge_2);
    F1 := internal_mesh_edge_face(OPPOSITE_EDGE);
    if region_id_from_face(planar_charts, F0) == region_id_from_face(planar_charts, F1) {
        return false;
    }
    return !internal_equal(
        index_explicit_10(*data.face_normals, F0),
        index_explicit_10(*data.face_normals, F1),
        K_NORMAL_EPSILON
    );
}

compute_normal_deviation_metric :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    face_2: u32
) -> float32 {
    FACE_NORMAL := ((cast(**Vector3) *(index_explicit_10(*data.face_normals, face_2))).*).*;

    return internal_min(
        (ifx true { temporary___g0: float32 = (1.0 - internal_dot(*FACE_NORMAL, *chart.basis.normal)); *temporary___g0; }),
        (ifx true { temporary___g1: float32 = 1.0; *temporary___g1; })
    );
}

push :: (using cost_queue: *Cost_Queue, cost: float32, face_2: u32) {
    P := Cost_Queue_Pair.{cost = cost, face = face_2};
    if is_empty(*pairs) || cost < peek_cost(cost_queue) {
        push_back(*pairs, *P);
    } else {
        i: u32 = 0;
        COUNT := size(*pairs);
        while i < COUNT {
            if (index_explicit_47(*pairs, i)).cost < cost {
                break;
            }
            i += 1;
        }
        insert_at(*pairs, i, *P);
        if size(*pairs) > max_size {
            remove_at(*pairs, 0);
        }
    }
}

remove_at :: (using array: *Array(Cost_Queue_Pair), index: u32) {
    remove_at(*base, index);
}

size :: (using array: *Array(Cost_Queue_Pair)) -> u32 {
    return base.size;
}

insert_at :: (using array: *Array(Cost_Queue_Pair), index: u32, value: *Cost_Queue_Pair) {
    insert_at(*base, index, cast(*u8) ((cast(**Cost_Queue_Pair) *(value)).*));
}

insert_at :: (using array_base: *Array_Base, index: u32, value: *u8) {
    assert(index >= 0 && index <= size);
    assert(value != null);
    resize(array_base, size + 1, false);
    assert(buffer != null);
    if buffer != null && index < size - 1 {
        move_memory(
            buffer + element_size * (index + 1),
            buffer + element_size * index,
            cast,no_check(u64) (element_size * ((size - 1) - index))
        );
    }
    if buffer != null && value != null {
        copy_memory(*buffer[index * element_size], value, cast,no_check(u64) element_size);
    }
}

index_explicit_47 :: (using array: *Array(Cost_Queue_Pair), index: u32) -> *Cost_Queue_Pair {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Cost_Queue_Pair) base.buffer)[index];
}

push_back :: (using array: *Array(Cost_Queue_Pair), value: *Cost_Queue_Pair) {
    push_back(*base, cast(*u8) ((cast(**Cost_Queue_Pair) *(value)).*));
}

peek_cost :: (using cost_queue: *Cost_Queue) -> float32 {
    return (back(*pairs)).cost;
}

contains :: (using array: *Array(u32), value: *u32) -> bool {
    {
        i: u32 = 0;
        while i < base.size {
            if (cast(*u32) base.buffer)[i] == value.* {
                return true;
            }
            i += 1;
        }
    }
    return false;
}

clear :: (using cost_queue: *Cost_Queue) {
    clear(*pairs);
}

clear :: (using array: *Array(Cost_Queue_Pair)) {
    clear(*base);
}

index_explicit_48 :: (using array: *Array(s32), index: u32) -> *s32 {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*s32) base.buffer)[index];
}

is_chart_parameterization_valid :: (using clustered_charts: *Clustered_Charts, chart: *Clustered_Charts_Chart) -> bool {
    FACE_COUNT := size(*chart.faces);

    flipped_face_count: u32 = 0;
    if 0 < FACE_COUNT {
        for i_2: 0..FACE_COUNT - 1 {
            if is_face_flipped(clustered_charts, ((cast(**u32) *(index_explicit_7(*chart.faces, i_2))).*).*) {
                flipped_face_count += 1;
            }
        }
    }
    if flipped_face_count != 0 && flipped_face_count != FACE_COUNT {
        return false;
    }

    reset(
        *boundary_grid,
        make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2(*texcoords),
        Const_Array_View(u32).{},
        0
    );
    if 0 < FACE_COUNT {
        for i: 0..FACE_COUNT - 1 {
            F: u32 = ((cast(**u32) *(index_explicit_7(*chart.faces, i))).*).*;
            for j: 0..cast(u32) 3 - 1 {
                EDGE := (F * 3) + j;
                if is_chart_boundary_edge(clustered_charts, chart, EDGE) {
                    append(*boundary_grid, EDGE);
                }
            }
        }
    }
    INTERSECTION :=
        intersect(
            *boundary_grid,
            epsilon(data.mesh),
            Const_Array_View(u32).{},
            Const_Array_View(u32).{}
        );

    if INTERSECTION {
        return false;
    }
    return true;
}

is_chart_boundary_edge :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    edge_2: u32
) -> bool {
    OPPOSITE_EDGE := opposite_edge(data.mesh, edge_2);
    OPPOSITE_FACE := internal_mesh_edge_face(OPPOSITE_EDGE);
    return OPPOSITE_EDGE == 4294967295 || ((cast(**s32) *(index_explicit_46(*face_charts, OPPOSITE_FACE))).*).* != chart.id;
}

is_face_flipped :: (using clustered_charts: *Clustered_Charts, face_2: u32) -> bool {
    v1: *Vector2 = cast,no_check(*Vector2) index_explicit_18(*texcoords, (face_2 * 3) + 0);
    v2: *Vector2 = cast,no_check(*Vector2) index_explicit_18(*texcoords, (face_2 * 3) + 1);
    v3: *Vector2 = cast,no_check(*Vector2) index_explicit_18(*texcoords, (face_2 * 3) + 2);
    PARAMETRIC_AREA := ((v2.x - v1.x) * (v3.y - v1.y) - (v3.x - v1.x) * (v2.y - v1.y)) * 0.5;
    return PARAMETRIC_AREA < 0.0;
}

parameterize_chart :: (using clustered_charts: *Clustered_Charts, chart: *Clustered_Charts_Chart) {
    FACE_COUNT := size(*chart.faces);
    if 0 < FACE_COUNT {
        for i: 0..FACE_COUNT - 1 {
            FACE: u32 = ((cast(**u32) *(index_explicit_7(*chart.faces, i))).*).*;
            for j: 0..cast(u32) 3 - 1 {
                OFFSET := (FACE * 3) + j;
                pos: *Vector3 = cast,no_check(*Vector3) position(data.mesh, vertex_at(data.mesh, OFFSET));
                assign(
                    index_explicit_4(*texcoords, OFFSET),
                    (ifx true { temporary___g0: Vector2 = make_vector2(internal_dot(*chart.basis.tangent, pos), internal_dot(*chart.basis.bitangent, pos)); *temporary___g0; })
                );
            }
        }
    }
}

compute_chart_basis :: (
    using clustered_charts: *Clustered_Charts,
    chart: *Clustered_Charts_Chart,
    basis: *Basis
) -> bool {
    FACE_COUNT := size(*chart.faces);
    resize(*temp_points, size(*chart.faces) * 3);
    if 0 < FACE_COUNT {
        for i: 0..FACE_COUNT - 1 {
            F: u32 = ((cast(**u32) *(index_explicit(*chart.faces, i))).*).*;
            for j: 0..cast(u32) 3 - 1 {
                assign_7(
                    index_explicit_10(*temp_points, (i * 3) + j),
                    position(data.mesh, vertex_at(data.mesh, (F * 3) + j))
                );
            }
        }
    }
    return compute_basis(make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector3(*temp_points), basis);
}

compute_basis :: (points: Const_Array_View(Vector3), basis: *Basis) -> bool {
    if compute_least_squares_normal(points, *basis.normal) {
        assign_9(
            *basis.tangent,
            (ifx true { temporary___g0: Vector3 = compute_tangent(*basis.normal); *temporary___g0; })
        );
        assign_9(
            *basis.bitangent,
            (ifx true { temporary___g1: Vector3 = compute_bitangent(*basis.normal, *basis.tangent); *temporary___g1; })
        );
        return true;
    }
    return compute_eigen(points, basis);
}

compute_eigen :: (points: Const_Array_View(Vector3), basis: *Basis) -> bool {
    matrix: [6] float32 = ---;
    compute_covariance(points, matrix.data);
    if matrix[0] == 0 && matrix[3] == 0 && matrix[5] == 0 {
        return false;
    }
    eigen_values: [3] float32 = ---;
    eigen_vectors: [3] Vector3 = ---;
    {
        cpp_transpiler_fixed_array_index_g64: u64 = 0;
        while cpp_transpiler_fixed_array_index_g64 < 3 {
            init(*eigen_vectors[cpp_transpiler_fixed_array_index_g64]);
            cpp_transpiler_fixed_array_index_g64 += 1;
        }
    }
    if !eigen_solve_symmetric3(matrix.data, eigen_values.data, eigen_vectors.data) {
        return false;
    }
    assign_9(
        *basis.normal,
        (ifx true { temporary___g0: Vector3 = internal_normalize(eigen_vectors.data + 2); *temporary___g0; })
    );
    assign_9(
        *basis.tangent,
        (ifx true { temporary___g1: Vector3 = internal_normalize(eigen_vectors.data + 0); *temporary___g1; })
    );
    assign_9(
        *basis.bitangent,
        (ifx true { temporary___g2: Vector3 = internal_normalize(eigen_vectors.data + 1); *temporary___g2; })
    );
    return true;
}

eigen_solve_symmetric3 :: (matrix: *float32, eigen_values: *float32, eigen_vectors: *Vector3) -> bool {
    assert(matrix != null && eigen_values != null && eigen_vectors != null);
    subd: [3] float32 = ---;
    diag: [3] float32 = ---;
    work: [3] [3] float32 = ---;
    work[0][0] = matrix[0];
    work[1][0] = matrix[1];
    work[0][1] = work[1][0];
    work[2][0] = matrix[2];
    work[0][2] = work[2][0];
    work[1][1] = matrix[3];
    work[2][1] = matrix[4];
    work[1][2] = work[2][1];
    work[2][2] = matrix[5];
    eigen_solver3_tridiagonal(work.data, diag.data, subd.data);
    if !eigen_solver3_ql_algorithm(work.data, diag.data, subd.data) {
        for i_3: 0..cast(s32) 3 - 1 {
            eigen_values[i_3] = 0;
            assign_9(*eigen_vectors[i_3], (ifx true { temporary___g0: Vector3 = make_vector3(0); *temporary___g0; }));
        }
        return false;
    }
    for i_2: 0..cast(s32) 3 - 1 {
        eigen_values[i_2] = diag[i_2];
    }

    for i: 0..cast(s32) 3 - 1 {
        for j: 0..cast(s32) 3 - 1 {
            assignment_55: float32 = work[i][j];
            ((*eigen_vectors[j].x)[i]) = assignment_55;
        }
    }

    if eigen_values[2] > eigen_values[0] && eigen_values[2] > eigen_values[1] {
        internal_swap(*eigen_values[0], *eigen_values[2]);
        internal_swap(*eigen_vectors[0], *eigen_vectors[2]);
    }
    if eigen_values[1] > eigen_values[0] {
        internal_swap(*eigen_values[0], *eigen_values[1]);
        internal_swap(*eigen_vectors[0], *eigen_vectors[1]);
    }
    if eigen_values[2] > eigen_values[1] {
        internal_swap(*eigen_values[1], *eigen_values[2]);
        internal_swap(*eigen_vectors[1], *eigen_vectors[2]);
    }
    assert(eigen_values[0] >= eigen_values[1] && eigen_values[0] >= eigen_values[2]);
    assert(eigen_values[1] >= eigen_values[2]);
    return true;
}

internal_swap :: (a: *Vector3, b: *Vector3) {
    temp := a.*;
    assign_7(a, b);
    assign_7(b, *temp);
}

eigen_solver3_ql_algorithm :: (mat: *[3] float32, diag: *float32, subd: *float32) -> bool {
    MAXITER: s32 = 32;
    for ell: 0..cast(s32) 3 - 1 {
        iter: s32 = 0;
        while iter < MAXITER {
            m := ell;
            while m <= 1 {
                dd := fabsf(diag[m]) + fabsf(diag[m + 1]);
                if fabsf(subd[m]) + dd == dd {
                    break;
                }
                m += 1;
            }
            if m == ell {
                break;
            }
            g := (diag[ell + 1] - diag[ell]) / ((cast(s32) 2) * subd[ell]);
            r := sqrtf(g * g + cast(s32) 1);
            if g < 0 {
                g = diag[m] - diag[ell] + subd[ell] / (g - r);
            } else {
                g = diag[m] - diag[ell] + subd[ell] / (g + r);
            }
            s: float32 = 1;
            c_: float32 = 1;
            p: float32 = 0;
            {
                i := m - 1;
                while i >= ell {
                    f := s * subd[i];
                    b := c_ * subd[i];
                    if fabsf(f) >= fabsf(g) {
                        c_ = g / f;
                        r = sqrtf(c_ * c_ + cast(s32) 1);
                        subd[i + 1] = f * r;
                        c_ *=
                            (ifx true { assignment_56: float32 = cast,no_check(float32) (((cast(s32) 1) /
                                r)); (s) = assignment_56; assignment_56; });
                    } else {
                        s = f / g;
                        r = sqrtf(s * s + cast(s32) 1);
                        subd[i + 1] = g * r;
                        s *=
                            (ifx true { assignment_57: float32 = cast,no_check(float32) (((cast(s32) 1) /
                                r)); (c_) = assignment_57; assignment_57; });
                    }
                    g = diag[i + 1] - p;
                    r = (diag[i] - g) * s + (cast(s32) 2) * b * c_;
                    p = s * r;
                    diag[i + 1] = g + p;
                    g = c_ * r - b;
                    for k: 0..cast(s32) 3 - 1 {
                        f = mat[k][i + 1];
                        mat[k][i + 1] = s * mat[k][i] + c_ * f;
                        mat[k][i] = c_ * mat[k][i] - s * f;
                    }
                    i -= 1;
                }
            }
            diag[ell] -= p;
            subd[ell] = g;
            subd[m] = 0;
            iter += 1;
        }
        if iter == MAXITER {
            return false;
        }
    }
    return true;
}

eigen_solver3_tridiagonal :: (mat: *[3] float32, diag: *float32, subd: *float32) {
    EPSILON: float32 = 1.0e-08;
    a := mat[0][0];
    b := mat[0][1];
    c_ := mat[0][2];
    d := mat[1][1];
    e_ := mat[1][2];
    f := mat[2][2];
    diag[0] = a;
    subd[2] = 0.0;
    if fabsf(c_) >= EPSILON {
        ELL := sqrtf(b * b + c_ * c_);
        b /= ELL;
        c_ /= ELL;
        Q := (cast(s32) 2) * b * e_ + c_ * (f - d);
        diag[1] = d + c_ * Q;
        diag[2] = f - c_ * Q;
        subd[0] = ELL;
        subd[1] = e_ - b * Q;
        mat[0][0] = 1;
        mat[0][1] = 0;
        mat[0][2] = 0;
        mat[1][0] = 0;
        mat[1][1] = b;
        mat[1][2] = c_;
        mat[2][0] = 0;
        mat[2][1] = c_;
        mat[2][2] = -b;
    } else {
        diag[1] = d;
        diag[2] = f;
        subd[0] = b;
        subd[1] = e_;
        mat[0][0] = 1;
        mat[0][1] = 0;
        mat[0][2] = 0;
        mat[1][0] = 0;
        mat[1][1] = 1;
        mat[1][2] = 0;
        mat[2][0] = 0;
        mat[2][1] = 0;
        mat[2][2] = 1;
    }
}

compute_covariance :: (points: Const_Array_View(Vector3), covariance: *float32) -> Vector3 {
    local_points: Const_Array_View(Vector3) = points;
    centroid_2 := compute_centroid(local_points);

    for i_2: 0..cast(s32) 6 - 1 {
        covariance[i_2] = 0.0;
    }
    {
        i: u32 = 0;
        while i < local_points.length {
            v := internal_operator_in_xatlas_2(index_explicit_14(*local_points, i), *centroid_2);
            covariance[0] += v.x * v.x;
            covariance[1] += v.x * v.y;
            covariance[2] += v.x * v.z;
            covariance[3] += v.y * v.y;
            covariance[4] += v.y * v.z;
            covariance[5] += v.z * v.z;
            i += 1;
        }
    }
    return centroid_2;
}

compute_bitangent :: (normal_2: *Vector3, tangent: *Vector3) -> Vector3 {
    return internal_cross(normal_2, tangent);
}

compute_tangent :: (normal_2: *Vector3) -> Vector3 {
    if !internal_is_normalized(normal_2, K_NORMAL_EPSILON) {
        if s_print != null {
            s_print(
                c_string("\rASSERT: %s %s %d\n"),
                c_string("isNormalized(normal)"),
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                cast(s32) 1263
            );
        }
    }

    tangent: Vector3 = ---;
    init(*tangent);
    if fabsf(normal_2.x) < fabsf(normal_2.y) && fabsf(normal_2.x) < fabsf(normal_2.z) {
        assign_9(*tangent, (ifx true { temporary___g0: Vector3 = make_vector3(1, 0, 0); *temporary___g0; }));
    } else if fabsf(normal_2.y) < fabsf(normal_2.z) {
        assign_9(*tangent, (ifx true { temporary___g1: Vector3 = make_vector3(0, 1, 0); *temporary___g1; }));
    } else {
        assign_9(*tangent, (ifx true { temporary___g2: Vector3 = make_vector3(0, 0, 1); *temporary___g2; }));
    }

    subtract_assign_2(
        *tangent,
        (ifx true { temporary___g4: Vector3 = internal_operator(normal_2, internal_dot(normal_2, *tangent)); *temporary___g4; })
    );
    assign_9(*tangent, (ifx true { temporary___g3: Vector3 = internal_normalize(*tangent); *temporary___g3; }));
    return tangent;
}

subtract_assign_2 :: (using vector3: *Vector3, v: *Vector3) {
    x -= v.x;
    y -= v.y;
    z -= v.z;
}

compute_least_squares_normal :: (points: Const_Array_View(Vector3), normal_2: *Vector3) -> bool {
    local_points: Const_Array_View(Vector3) = points;
    assert(local_points.length >= 3);
    if local_points.length == 3 {
        assign_9(
            normal_2,
            (ifx true { temporary___g4: Vector3 = internal_normalize(
            (ifx true { temporary___g2: Vector3 = internal_cross(
            (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(index_explicit_14(*local_points, 2), index_explicit_14(*local_points, 0)); *temporary___g0; }),
            (ifx true { temporary___g1: Vector3 = internal_operator_in_xatlas_2(index_explicit_14(*local_points, 1), index_explicit_14(*local_points, 0)); *temporary___g1; })
        ); *temporary___g2; })
        ); *temporary___g4; })
        );
        return true;
    }
    INV_N := 1.0 / local_points.length;
    centroid_2: Vector3 = make_vector3(0.0);
    {
        i_2: u32 = 0;
        while i_2 < local_points.length {
            add_assign(*centroid_2, index_explicit_14(*local_points, i_2));
            i_2 += 1;
        }
    }
    multiply_assign_2(*centroid_2, INV_N);

    xx_: float32 = 0.0;
    xy_2: float32 = 0.0;
    xz: float32 = 0.0;
    yy: float32 = 0.0;
    yz: float32 = 0.0;
    zz: float32 = 0.0;
    {
        i: u32 = 0;
        while i < local_points.length {
            r := internal_operator_in_xatlas_2(index_explicit_14(*local_points, i), *centroid_2);
            xx_ += r.x * r.x;
            xy_2 += r.x * r.y;
            xz += r.x * r.z;
            yy += r.y * r.y;
            yz += r.y * r.z;
            zz += r.z * r.z;
            i += 1;
        }
    }

    DET_X := yy * zz - yz * yz;
    DET_Y := xx_ * zz - xz * xz;
    DET_Z := xx_ * yy - xy_2 * xy_2;
    DET_MAX :=
        internal_max(
            *DET_X,
            (ifx true { temporary___g3: float32 = internal_max(*DET_Y, *DET_Z); *temporary___g3; })
        );
    if DET_MAX <= 0.0 {
        return false;
    }

    dir: Vector3 = make_vector3(0.0);
    if DET_MAX == DET_X {
        assign_9(
            *dir,
            (ifx true { temporary___g6: Vector3 = make_vector3(DET_X, xz * yz -
            xy_2 * zz, xy_2 * yz - xz * yy); *temporary___g6; })
        );
    } else if DET_MAX == DET_Y {
        assign_9(
            *dir,
            (ifx true { temporary___g5: Vector3 = make_vector3(xz * yz -
            xy_2 * zz, DET_Y, xy_2 * xz - yz * xx_); *temporary___g5; })
        );
    } else if DET_MAX == DET_Z {
        assign_9(
            *dir,
            (ifx true { temporary___g8: Vector3 = make_vector3(xy_2 * yz -
            xz * yy, xy_2 * xz - yz * xx_, DET_Z); *temporary___g8; })
        );
    }
    LEN := internal_length(*dir);
    if internal_is_zero(LEN, K_EPSILON) {
        return false;
    }
    assign_9(normal_2, (ifx true { temporary___g7: Vector3 = internal_operator(*dir, 1.0 / LEN); *temporary___g7; }));

    return internal_is_normalized(normal_2, K_NORMAL_EPSILON);
}

multiply_assign_2 :: (using vector3: *Vector3, s: float32) {
    x *= s;
    y *= s;
    z *= s;
}

resize :: (using array: *Array(Vector3), new_size: u32) {
    resize(*base, new_size, true);
}

unset :: (using bit_array: *Bit_Array, index: u32) {
    assert(index < size);
    c_transpiler_compound_and(*(((cast(**u32) *(index_explicit(*word_array, index >> 5))).*).*), (cast,no_check(u32) (~((cast(s32) 1) << (index & 31)))), u32, u32);
}

relocate_seeds :: (using clustered_charts: *Clustered_Charts) -> bool {
    any_seed_changed: bool = false;
    CHART_COUNT := size(*charts);
    if 0 < CHART_COUNT {
        for i: 0..CHART_COUNT - 1 {
            if relocate_seed(clustered_charts, (cast(**Clustered_Charts_Chart) index_explicit_11(*charts, i)).*) {
                any_seed_changed = true;
            }
        }
    }

    return any_seed_changed;
}

relocate_seed :: (using clustered_charts: *Clustered_Charts, chart: *Clustered_Charts_Chart) -> bool {
    FACE_COUNT := size(*chart.faces);
    clear(*best_triangles);
    if 0 < FACE_COUNT {
        for i: 0..FACE_COUNT - 1 {
            COST :=
                compute_normal_deviation_metric(
                    clustered_charts,
                    chart,
                    ((cast(**u32) *(index_explicit(*chart.faces, i))).*).*
                );
            push(*best_triangles, COST, ((cast(**u32) *(index_explicit(*chart.faces, i))).*).*);
        }
    }

    most_central: u32 = 0;
    min_distance: float32 = cast(float32) 3.40282347e+38;
    while true {
        if count(*best_triangles) == 0 {
            break;
        }
        FACE := pop(*best_triangles);
        face_centroid := compute_face_center(data.mesh, FACE);
        DISTANCE :=
            internal_length(
                (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(*chart.centroid, *face_centroid); *temporary___g0; })
            );
        if DISTANCE < min_distance {
            min_distance = DISTANCE;
            most_central = FACE;
        }
    }
    assert(min_distance < cast(float32) 3.40282347e+38);
    if most_central == chart.seed {
        return false;
    }
    chart.seed = most_central;
    return true;
}

count :: (using cost_queue: *Cost_Queue) -> u32 {
    return size(*pairs);
}

merge_charts :: (using clustered_charts: *Clustered_Charts) {
    CHART_COUNT: u32 = ---;
    merged: bool = ---;
    c_: s32 = ---;
    chart: *Clustered_Charts_Chart = ---;
    external_boundary_length: float32 = ---;
    FACE_COUNT_2: u32 = ---;
    i: u32 = ---;
    F: u32 = ---;
    it_: Mesh_Face_Edge_Iterator = ---;
    L: float32 = ---;
    NEIGHBOR_CHART: s32 = ---;
    cc: s32 = ---;
    chart2: *Clustered_Charts_Chart = ---;
    c__: s32 = ---;
    FACE_COUNT: u32 = ---;
    i_2: u32 = ---;
    code_block_to_execute: s64 = 84;
    // The transpiler had to use this control-flow loop because the source code used a goto, which Jai does not support.
    while c_transpiler_dispatch := true {
        if code_block_to_execute < 0 break;
        if code_block_to_execute == {
            case 0; {
                code_block_to_execute = 27;
                continue c_transpiler_dispatch;
            }
            case 1; {
                if c__ < cast,no_check(s32) size(*charts) code_block_to_execute = 13;
                else code_block_to_execute = -1;
                continue c_transpiler_dispatch;
            }
            case 3; {
                assignment_58: s32 = c__;
                (((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, cast,no_check(u32) c__)).*).id) = assignment_58;
                c__ += 1;
                code_block_to_execute = 1;
                continue c_transpiler_dispatch;
            }
            case 4; {
                if i_2 < FACE_COUNT code_block_to_execute = 9;
                else code_block_to_execute = 1;
                continue c_transpiler_dispatch;
            }
            case 5; {
                i_2 += 1;
                code_block_to_execute = 4;
                continue c_transpiler_dispatch;
            }
            case 6; {
                ((cast(**s32) *(index_explicit_48(*face_charts, i_2))).*).* -= 1;
                code_block_to_execute = 5;
                continue c_transpiler_dispatch;
            }
            case 9; {
                assert(((cast(**s32) *(index_explicit_48(*face_charts, i_2))).*).* != c__);
                assert(((cast(**s32) *(index_explicit_48(*face_charts, i_2))).*).* <= cast,no_check(s32) size(*charts));
                if ((cast(**s32) *(index_explicit_48(*face_charts, i_2))).*).* > c__ code_block_to_execute = 6;
                else code_block_to_execute = 5;
                continue c_transpiler_dispatch;
            }
            case 12; {
                remove_at(*charts, cast,no_check(u32) c__);
                FACE_COUNT = size(*face_charts);
                i_2 = 0;
                code_block_to_execute = 4;
                continue c_transpiler_dispatch;
            }
            case 13; {
                if (cast(**Clustered_Charts_Chart) index_explicit_11(*charts, cast,no_check(u32) c__)).* == null code_block_to_execute = 12;
                else code_block_to_execute = 3;
                continue c_transpiler_dispatch;
            }
            case 15; {
                code_block_to_execute = 83;
                continue c_transpiler_dispatch;
            }
            case 16; {
                c__ = 0;
                code_block_to_execute = 1;
                continue c_transpiler_dispatch;
            }
            case 17; {
                if !merged code_block_to_execute = 16;
                else code_block_to_execute = 15;
                continue c_transpiler_dispatch;
            }
            case 18; {
                if c_ >= 0 code_block_to_execute = 81;
                else code_block_to_execute = 17;
                continue c_transpiler_dispatch;
            }
            case 19; {
                c_ -= 1;
                code_block_to_execute = 18;
                continue c_transpiler_dispatch;
            }
            case 20; {
                code_block_to_execute = 17;
                continue c_transpiler_dispatch;
            }
            case 21; {
                if merged code_block_to_execute = 20;
                else code_block_to_execute = 19;
                continue c_transpiler_dispatch;
            }
            case 22; {
                if cc >= 0 code_block_to_execute = 49;
                else code_block_to_execute = 21;
                continue c_transpiler_dispatch;
            }
            case 23; {
                cc -= 1;
                code_block_to_execute = 22;
                continue c_transpiler_dispatch;
            }
            case 25; {
                merged = true;
                code_block_to_execute = 21;
                continue c_transpiler_dispatch;
            }
            case 26; {
                code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 27; {
                if !merge_chart(
                    clustered_charts,
                    chart,
                    chart2,
                    ((cast(**float32) *(index_explicit_26(*shared_boundary_lengths_no_seams, cast,no_check(u32) cc))).*).*
                ) code_block_to_execute = 26;
                else code_block_to_execute = 25;
                continue c_transpiler_dispatch;
            }
            case 28; {
                code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 29; {
                code_block_to_execute = 0;
                continue c_transpiler_dispatch;
            }
            case 30; {
                if ((cast(**float32) *(index_explicit_26(*shared_boundary_lengths, cast,no_check(u32) cc))).*).* > 0.2 * internal_max(
                    (ifx true { temporary___g0: float32 = 0.0; *temporary___g0; }),
                    (ifx true { temporary___g1: float32 = (chart.boundary_length -
                    external_boundary_length); *temporary___g1; })
                ) || ((cast(**float32) *(index_explicit_26(*shared_boundary_lengths, cast,no_check(u32) cc))).*).* > 0.75 * chart2.boundary_length code_block_to_execute = 29;
                else code_block_to_execute = 28;
                continue c_transpiler_dispatch;
            }
            case 31; {
                code_block_to_execute = 0;
                continue c_transpiler_dispatch;
            }
            case 32; {
                if ((cast(**float32) *(index_explicit_26(*shared_boundary_lengths_no_seams, cast,no_check(u32) cc))).*).* > 0.0 && internal_equal(
                    ((cast(**float32) *(index_explicit_26(*shared_boundary_lengths_no_seams, cast,no_check(u32) cc))).*).*,
                    chart2.boundary_length,
                    K_EPSILON
                ) code_block_to_execute = 31;
                else code_block_to_execute = 30;
                continue c_transpiler_dispatch;
            }
            case 33; {
                code_block_to_execute = 0;
                continue c_transpiler_dispatch;
            }
            case 34; {
                if size(*chart2.faces) == 2 && ((cast(**u32) *(index_explicit(*shared_boundary_edge_count_no_seams, cast,no_check(u32) cc))).*).* >= 2 code_block_to_execute = 33;
                else code_block_to_execute = 32;
                continue c_transpiler_dispatch;
            }
            case 35; {
                code_block_to_execute = 0;
                continue c_transpiler_dispatch;
            }
            case 36; {
                if ((cast(**float32) *(index_explicit_26(*shared_boundary_lengths_no_seams, cast,no_check(u32) cc))).*).* > 0.0 && size(*chart.faces) > 1 && size(*chart2.faces) == 1 && chart2.area <= chart.area * 0.1 code_block_to_execute = 35;
                else code_block_to_execute = 34;
                continue c_transpiler_dispatch;
            }
            case 37; {
                code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 38; {
                if data.options.max_boundary_length > 0.0 && (chart.boundary_length + chart2.boundary_length - ((cast(**float32) *(index_explicit_26(*shared_boundary_lengths_no_seams, cast,no_check(u32) cc))).*).*) > data.options.max_boundary_length code_block_to_execute = 37;
                else code_block_to_execute = 36;
                continue c_transpiler_dispatch;
            }
            case 39; {
                code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 40; {
                if data.options.max_chart_area > 0.0 && chart.area + chart2.area > data.options.max_chart_area code_block_to_execute = 39;
                else code_block_to_execute = 38;
                continue c_transpiler_dispatch;
            }
            case 41; {
                code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 42; {
                if internal_dot(*chart2.basis.normal, *chart.basis.normal) < 0.5 code_block_to_execute = 41;
                else code_block_to_execute = 40;
                continue c_transpiler_dispatch;
            }
            case 43; {
                code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 44; {
                if ((cast(**float32) *(index_explicit_26(*shared_boundary_lengths, cast,no_check(u32) cc))).*).* <= 0.0 code_block_to_execute = 43;
                else code_block_to_execute = 42;
                continue c_transpiler_dispatch;
            }
            case 45; {
                code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 47; {
                chart2 = cast,no_check(*Clustered_Charts_Chart) ((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, cast,no_check(u32) cc)).*);
                if chart2 == null code_block_to_execute = 45;
                else code_block_to_execute = 44;
                continue c_transpiler_dispatch;
            }
            case 48; {
                code_block_to_execute = 23;
                continue c_transpiler_dispatch;
            }
            case 49; {
                if cc == c_ code_block_to_execute = 48;
                else code_block_to_execute = 47;
                continue c_transpiler_dispatch;
            }
            case 50; {
                cc = cast,no_check(s32) (CHART_COUNT - 1);
                code_block_to_execute = 22;
                continue c_transpiler_dispatch;
            }
            case 51; {
                if i < FACE_COUNT_2 code_block_to_execute = 69;
                else code_block_to_execute = 50;
                continue c_transpiler_dispatch;
            }
            case 52; {
                i += 1;
                code_block_to_execute = 51;
                continue c_transpiler_dispatch;
            }
            case 53; {
                if !is_done(*it_) code_block_to_execute = 66;
                else code_block_to_execute = 52;
                continue c_transpiler_dispatch;
            }
            case 54; {
                advance(*it_);
                code_block_to_execute = 53;
                continue c_transpiler_dispatch;
            }
            case 56; {
                c_transpiler_compound_add(*(((cast(**float32) *(index_explicit_26(*shared_boundary_lengths_no_seams, cast,no_check(u32) NEIGHBOR_CHART))).*).*), (L), float32, float32);
                ((cast(**u32) *(index_explicit(*shared_boundary_edge_count_no_seams, cast,no_check(u32) NEIGHBOR_CHART))).*).* += 1;
                code_block_to_execute = 54;
                continue c_transpiler_dispatch;
            }
            case 57; {
                c_transpiler_compound_add(*(((cast(**float32) *(index_explicit_26(*shared_boundary_lengths, cast,no_check(u32) NEIGHBOR_CHART))).*).*), (L), float32, float32);
                code_block_to_execute = 56;
                continue c_transpiler_dispatch;
            }
            case 58; {
                external_boundary_length += L;
                code_block_to_execute = 56;
                continue c_transpiler_dispatch;
            }
            case 59; {
                if is_seam(*it_) && (is_normal_seam(clustered_charts, edge(*it_)) || is_texture_seam(*it_)) code_block_to_execute = 58;
                else code_block_to_execute = 57;
                continue c_transpiler_dispatch;
            }
            case 60; {
                if (cast(**Clustered_Charts_Chart) index_explicit_11(*charts, cast,no_check(u32) NEIGHBOR_CHART)).* != chart code_block_to_execute = 59;
                else code_block_to_execute = 54;
                continue c_transpiler_dispatch;
            }
            case 61; {
                external_boundary_length += L;
                code_block_to_execute = 54;
                continue c_transpiler_dispatch;
            }
            case 63; {
                NEIGHBOR_CHART = ((cast(**s32) *(index_explicit_48(*face_charts, opposite_face(*it_)))).*).*;
                if NEIGHBOR_CHART == -1 code_block_to_execute = 61;
                else code_block_to_execute = 60;
                continue c_transpiler_dispatch;
            }
            case 64; {
                external_boundary_length += L;
                code_block_to_execute = 54;
                continue c_transpiler_dispatch;
            }
            case 66; {
                L = ((cast(**float32) *(index_explicit_26(*data.edge_lengths, edge(*it_)))).*).*;
                if is_boundary(*it_) code_block_to_execute = 64;
                else code_block_to_execute = 63;
                continue c_transpiler_dispatch;
            }
            case 69; {
                F = ((cast(**u32) *(index_explicit(*chart.faces, i))).*).*;
                init(*it_, data.mesh, F);
                code_block_to_execute = 53;
                continue c_transpiler_dispatch;
            }
            case 78; {
                external_boundary_length = 0.0;
                resize(*shared_boundary_lengths, CHART_COUNT);
                zero_out_memory(*shared_boundary_lengths);
                resize(*shared_boundary_lengths_no_seams, CHART_COUNT);
                zero_out_memory(*shared_boundary_lengths_no_seams);
                resize(*shared_boundary_edge_count_no_seams, CHART_COUNT);
                zero_out_memory(*shared_boundary_edge_count_no_seams);
                FACE_COUNT_2 = size(*chart.faces);
                i = 0;
                code_block_to_execute = 51;
                continue c_transpiler_dispatch;
            }
            case 79; {
                code_block_to_execute = 19;
                continue c_transpiler_dispatch;
            }
            case 81; {
                chart = cast,no_check(*Clustered_Charts_Chart) ((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, cast,no_check(u32) c_)).*);
                if chart == null code_block_to_execute = 79;
                else code_block_to_execute = 78;
                continue c_transpiler_dispatch;
            }
            case 83; {
                merged = false;
                c_ = cast,no_check(s32) (CHART_COUNT - 1);
                code_block_to_execute = 18;
                continue c_transpiler_dispatch;
            }
            case 84; {
                CHART_COUNT = size(*charts);
                code_block_to_execute = 15;
                continue c_transpiler_dispatch;
            }
        }
        assert(false, tprint("invalid code block to execute %", code_block_to_execute));
        break;
    }
}

remove_at :: (using array: *Array(*Clustered_Charts_Chart), index: u32) {
    remove_at(*base, index);
}

merge_chart :: (
    using clustered_charts: *Clustered_Charts,
    owner: *Clustered_Charts_Chart,
    chart: *Clustered_Charts_Chart,
    shared_boundary_length: float32
) -> bool {
    OLD_OWNER_FACE_COUNT := size(*owner.faces);
    CHART_FACE_COUNT := size(*chart.faces);
    push_back(*owner.faces, *chart.faces);
    if 0 < CHART_FACE_COUNT {
        for i_3: 0..CHART_FACE_COUNT - 1 {
            assert(((cast(**s32) *(index_explicit_48(*face_charts, ((cast(**u32) *(index_explicit(*chart.faces, i_3))).*).*))).*).* == chart.id);
            assignment_59: s32 = owner.id;
            (((cast(**s32) *(index_explicit_48(*face_charts, ((cast(**u32) *(index_explicit(*chart.faces, i_3))).*).*))).*).*) = assignment_59;
        }
    }

    basis: Basis = ---;
    init(*basis);
    if !compute_chart_basis(clustered_charts, owner, *basis) {
        resize(*owner.faces, OLD_OWNER_FACE_COUNT);
        if 0 < CHART_FACE_COUNT {
            for i_2: 0..CHART_FACE_COUNT - 1 {
                assignment_60: s32 = chart.id;
                (((cast(**s32) *(index_explicit_48(*face_charts, ((cast(**u32) *(index_explicit(*chart.faces, i_2))).*).*))).*).*) = assignment_60;
            }
        }
        return false;
    }
    if internal_dot(
        *basis.normal,
        index_explicit_10(*data.face_normals, ((cast(**u32) *(index_explicit(*owner.faces, 0))).*).*)
    ) < 0.0 {
        assign_9(*basis.normal, (ifx true { temporary___g0: Vector3 = subtract(*basis.normal); *temporary___g0; }));
    }

    parameterize_chart(clustered_charts, owner);
    if !is_chart_parameterization_valid(clustered_charts, owner) {
        resize(*owner.faces, OLD_OWNER_FACE_COUNT);
        if 0 < CHART_FACE_COUNT {
            for i: 0..CHART_FACE_COUNT - 1 {
                assignment_61: s32 = chart.id;
                (((cast(**s32) *(index_explicit_48(*face_charts, ((cast(**u32) *(index_explicit(*chart.faces, i))).*).*))).*).*) = assignment_61;
            }
        }
        return false;
    }

    owner.basis = basis;
    push_back(*owner.failed_planar_regions, *chart.failed_planar_regions);

    owner.area += chart.area;
    owner.boundary_length += chart.boundary_length - shared_boundary_length;

    (cast(**Clustered_Charts_Chart) index_explicit_11(*charts, cast,no_check(u32) chart.id)).* =
        cast(*Clustered_Charts_Chart) null;
    deinit(chart);
    internal_realloc(
        cast(*void) chart,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        6089
    );
    return true;
}

deinit :: (using chart: *Clustered_Charts_Chart) {
    cpp_transpiler_subobject_cleanup_g65: bool = ---;
    defer deinit(*faces);
    cpp_transpiler_subobject_cleanup_g66: bool = ---;
    defer deinit(*failed_planar_regions);
    cpp_transpiler_subobject_cleanup_g67: bool = ---;
    defer deinit(*candidates);
}

push_back :: (using array: *Array(u32), other: *Array(u32)) {
    push_back(*base, *other.base);
}

push_back :: (using array_base: *Array_Base, other: *Array_Base) {
    assert(element_size == other.element_size);
    if other.size > 0 {
        OLD_SIZE := size;
        resize(array_base, size + other.size, false);
        assert(buffer != null);
        if buffer != null {
            copy_memory(
                buffer + OLD_SIZE * element_size,
                other.buffer,
                cast,no_check(u64) (other.size * other.element_size)
            );
        }
    }
}

zero_out_memory :: (using array: *Array(float32)) {
    if base.buffer != null && base.size > 0 {
        fill_memory(base.buffer, 0, cast,no_check(u64) (base.element_size * base.size));
    }
}

fill_holes :: (using clustered_charts: *Clustered_Charts, threshold: float32) {
    while faces_left > 0 {
        create_chart(clustered_charts, threshold);
    }
}

create_chart :: (using clustered_charts: *Clustered_Charts, threshold: float32) {
    chart :=
        cast(*Clustered_Charts_Chart) (cast(*void) (cast(*Clustered_Charts_Chart) internal_realloc(
            null,
            160,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            5627
        )));
    init(chart);
    chart.id = cast,no_check(s32) size(*charts);
    push_back(*charts, *chart);

    chart.seed = 0;
    largest_area: float32 = 0.0;
    {
        f: u32 = 0;
        while f < face_count(data.mesh) {
            if get(*data.is_face_in_chart, f) {
                f += 1;
                continue;
            }
            AREA := region_area(planar_charts, region_id_from_face(planar_charts, f));
            if AREA > largest_area {
                largest_area = AREA;
                chart.seed = f;
            }
            f += 1;
        }
    }
    add_face_to_chart(clustered_charts, chart, chart.seed);

    while true {
        if count(*chart.candidates) == 0 || peek_cost(*chart.candidates) > threshold {
            break;
        }
        F := pop(*chart.candidates);
        if get(*data.is_face_in_chart, F) {
            continue;
        }
        if !add_face_to_chart(clustered_charts, chart, F) {
            push_back(
                *chart.failed_planar_regions,
                (ifx true { temporary___g0: u32 = region_id_from_face(planar_charts, F); *temporary___g0; })
            );
            continue;
        }
    }
}

region_area :: (using planar_charts: *Planar_Charts, region: u32) -> float32 {
    return ((cast(**float32) *(index_explicit_25(*region_areas, region))).*).*;
}

push_back :: (using array: *Array(*Clustered_Charts_Chart), value: **Clustered_Charts_Chart) {
    push_back(*base, cast(*u8) (cast(**Clustered_Charts_Chart) value));
}

grow_charts :: (using clustered_charts: *Clustered_Charts, threshold: float32) {
    while true {
        if faces_left == 0 {
            break;
        }

        best_face: u32 = 4294967295;
        best_chart: u32 = 4294967295;
        lowest_cost: float32 = cast(float32) 3.40282347e+38;
        {
            i: u32 = 0;
            while i < size(*charts) {
                chart_2: *Clustered_Charts_Chart =
                    cast,no_check(*Clustered_Charts_Chart) ((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, i)).*);

                face_2: u32 = 4294967295;
                cost: float32 = cast(float32) 3.40282347e+38;
                while true {
                    if count(*chart_2.candidates) == 0 {
                        break;
                    }
                    cost = peek_cost(*chart_2.candidates);
                    face_2 = peek_face(*chart_2.candidates);
                    if !get(*data.is_face_in_chart, face_2) {
                        break;
                    } else {
                        pop(*chart_2.candidates);
                        face_2 = 4294967295;
                    }
                }
                if face_2 == 4294967295 {
                    i += 1;
                    continue;
                }

                if cost < lowest_cost {
                    lowest_cost = cost;
                    best_face = face_2;
                    best_chart = i;
                }
                i += 1;
            }
        }
        if best_face == 4294967295 || lowest_cost > threshold {
            break;
        }
        chart: *Clustered_Charts_Chart =
            cast,no_check(*Clustered_Charts_Chart) ((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, best_chart)).*);
        pop(*chart.candidates);
        if !add_face_to_chart(clustered_charts, chart, best_face) {
            push_back(
                *chart.failed_planar_regions,
                (ifx true { temporary___g0: u32 = region_id_from_face(planar_charts, best_face); *temporary___g0; })
            );
        }
    }
}

peek_face :: (using cost_queue: *Cost_Queue) -> u32 {
    return (back(*pairs)).face;
}

place_seeds :: (using clustered_charts: *Clustered_Charts, threshold: float32) {
    placing_seeds = true;

    while faces_left > 0 {
        create_chart(clustered_charts, threshold);
    }
    placing_seeds = false;
}

fill :: (using array: *Array(s32), value: *s32) {
    buffer := cast(*s32) base.buffer;
    {
        i: u32 = 0;
        while i < base.size {
            buffer[i] = value.*;
            i += 1;
        }
    }
}

resize :: (using array: *Array(s32), new_size: u32) {
    resize(*base, new_size, true);
}

clear :: (using array: *Array(*Clustered_Charts_Chart)) {
    clear(*base);
}

compute :: (using planar_charts: *Planar_Charts) {
    FACE_COUNT := face_count(data.mesh);

    clear(*region_first_face);
    resize(*next_region_face, FACE_COUNT);
    resize(*face_to_region_id, FACE_COUNT);
    if 0 < FACE_COUNT {
        for f_3: 0..FACE_COUNT - 1 {
            assignment_62: u32 = f_3;
            (((cast(**u32) *(index_explicit(*next_region_face, f_3))).*).*) = assignment_62;
            ((cast(**u32) *(index_explicit(*face_to_region_id, f_3))).*).* = 4294967295;
        }
    }
    face_stack: Array(u32) = ---;
    defer deinit(*face_stack);
    init(*face_stack, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    reserve(*face_stack, internal_min(*FACE_COUNT, (ifx true { temporary___g0: u32 = cast(u32) 16; *temporary___g0; })));
    region_count: u32 = 0;
    {
        f_2: u32 = 0;
        while f_2 < FACE_COUNT {
            if ((cast(**u32) *(index_explicit(*next_region_face, f_2))).*).* != f_2 {
                f_2 += 1;
                continue;
            }
            if get(*data.is_face_in_chart, f_2) {
                f_2 += 1;
                continue;
            }
            clear(*face_stack);
            push_back(*face_stack, *f_2);
            while true {
                if is_empty(*face_stack) {
                    break;
                }
                FACE: u32 = ((cast(**u32) *(back(*face_stack))).*).*;
                assignment_63: u32 = region_count;
                (((cast(**u32) *(index_explicit(*face_to_region_id, FACE))).*).*) = assignment_63;
                pop_back(*face_stack);
                {
                    it__2: Mesh_Face_Edge_Iterator = ---;
                    init(*it__2, data.mesh, FACE);
                    while !is_done(*it__2) {
                        OFACE_2 := opposite_face(*it__2);
                        if is_boundary(*it__2) {
                            advance(*it__2);
                            continue;
                        }
                        if ((cast(**u32) *(index_explicit(*next_region_face, OFACE_2))).*).* != OFACE_2 {
                            advance(*it__2);
                            continue;
                        }
                        if get(*data.is_face_in_chart, OFACE_2) {
                            advance(*it__2);
                            continue;
                        }
                        if !internal_equal(
                            internal_dot(
                            index_explicit_10(*data.face_normals, FACE),
                            index_explicit_10(*data.face_normals, OFACE_2)
                        ),
                            1.0,
                            K_EPSILON
                        ) {
                            advance(*it__2);
                            continue;
                        }
                        NEXT: u32 = ((cast(**u32) *(index_explicit(*next_region_face, FACE))).*).*;
                        assignment_64: u32 = OFACE_2;
                        (((cast(**u32) *(index_explicit(*next_region_face, FACE))).*).*) = assignment_64;
                        assignment_65: u32 = NEXT;
                        (((cast(**u32) *(index_explicit(*next_region_face, OFACE_2))).*).*) = assignment_65;
                        assignment_66: u32 = region_count;
                        (((cast(**u32) *(index_explicit(*face_to_region_id, OFACE_2))).*).*) = assignment_66;
                        push_back(*face_stack, *OFACE_2);
                        advance(*it__2);
                    }
                }
            }
            push_back(*region_first_face, *f_2);
            region_count += 1;
            f_2 += 1;
        }
    }

    resize(*region_areas, region_count);
    zero_out_memory(*region_areas);
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            if ((cast(**u32) *(index_explicit(*face_to_region_id, f))).*).* == 4294967295 {
                continue;
            }
            c_transpiler_compound_add(*(((cast(**float32) *(index_explicit_26(*region_areas, ((cast(**u32) *(index_explicit(*face_to_region_id, f))).*).*))).*).*), (((cast(**float32) *(index_explicit_26(*data.face_areas, f))).*).*), float32, float32);
        }
    }

    clear(*charts);
    clear(*chart_faces);
    if 0 < region_count {
        for region: 0..region_count - 1 {
            FIRST_REGION_FACE: u32 = ((cast(**u32) *(index_explicit(*region_first_face, region))).*).*;
            face_2 := FIRST_REGION_FACE;
            create_chart_2: bool = true;
            while true {
                {
                    it_: Mesh_Face_Edge_Iterator = ---;
                    init(*it_, data.mesh, face_2);
                    while !is_done(*it_) {
                        if is_boundary(*it_) {
                            advance(*it_);
                            continue;
                        }
                        OFACE := opposite_face(*it_);
                        if ((cast(**u32) *(index_explicit(*face_to_region_id, OFACE))).*).* == region {
                            advance(*it_);
                            continue;
                        }
                        ANGLE := ((cast(**float32) *(index_explicit_26(*data.edge_dihedral_angles, edge(*it_)))).*).*;
                        if ANGLE > 0.0 && ANGLE < cast(float32) 3.40282347e+38 {
                            create_chart_2 = false;
                            break;
                        }
                        advance(*it_);
                    }
                }
                if !create_chart_2 {
                    break;
                }
                face_2 = ((cast(**u32) *(index_explicit(*next_region_face, face_2))).*).*;
                if !(face_2 != FIRST_REGION_FACE) break;
            }

            if create_chart_2 {
                chart: Planar_Charts_Chart = ---;
                chart.first_face = size(*chart_faces);
                chart.face_count = 0;
                face_2 = FIRST_REGION_FACE;
                while true {
                    set(*data.is_face_in_chart, face_2);
                    push_back(*chart_faces, *face_2);
                    chart.face_count += 1;
                    face_2 = ((cast(**u32) *(index_explicit(*next_region_face, face_2))).*).*;
                    if !(face_2 != FIRST_REGION_FACE) break;
                }
                push_back(*charts, *chart);
            }
        }
    }

    resize(*chart_basis, size(*charts));
    {
        c_: u32 = 0;
        while c_ < size(*charts) {
            FACE_2: u32 =
                ((cast(**u32) *(index_explicit(*chart_faces, (index_explicit_50(*charts, c_)).first_face))).*).*;
            basis: *Basis = cast,no_check(*Basis) index_explicit_49(*chart_basis, c_);
            assign_7(*basis.normal, index_explicit_10(*data.face_normals, FACE_2));
            assign_9(
                *basis.tangent,
                (ifx true { temporary___g1: Vector3 = compute_tangent(*basis.normal); *temporary___g1; })
            );
            assign_9(
                *basis.bitangent,
                (ifx true { temporary___g2: Vector3 = compute_bitangent(*basis.normal, *basis.tangent); *temporary___g2; })
            );
            c_ += 1;
        }
    }
}

index_explicit_49 :: (using array: *Array(Basis), index: u32) -> *Basis {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Basis) base.buffer)[index];
}

index_explicit_50 :: (using array: *Array(Planar_Charts_Chart), index: u32) -> *Planar_Charts_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Planar_Charts_Chart) base.buffer)[index];
}

resize :: (using array: *Array(Basis), new_size: u32) {
    resize(*base, new_size, true);
}

push_back :: (using array: *Array(Planar_Charts_Chart), value: *Planar_Charts_Chart) {
    push_back(*base, cast(*u8) ((cast(**Planar_Charts_Chart) *(value)).*));
}

clear :: (using array: *Array(Planar_Charts_Chart)) {
    clear(*base);
}

pop_back :: (using array: *Array(u32)) {
    pop_back(*base);
}

compute :: (using original_uv_charts: *Original_Uv_Charts) {
    clear(*charts);
    clear(*chart_faces);
    mesh := data.mesh;
    FACE_COUNT := face_count(mesh);
    {
        f_2: u32 = 0;
        while f_2 < FACE_COUNT {
            if get(*data.is_face_in_chart, f_2) {
                f_2 += 1;
                continue;
            }
            if internal_is_zero(((cast(**float32) *(index_explicit_26(*data.face_uv_areas, f_2))).*).*, K_AREA_EPSILON) {
                f_2 += 1;
                continue;
            }

            chart: Original_Uv_Charts_Chart = ---;
            chart.first_face = size(*chart_faces);
            chart.face_count = 1;
            push_back(*chart_faces, *f_2);
            set(*data.is_face_in_chart, f_2);
            floodfill_faces(original_uv_charts, *chart);
            push_back(*charts, *chart);
            f_2 += 1;
        }
    }

    resize(*chart_basis, size(*charts));
    {
        c_: u32 = 0;
        while c_ < size(*charts) {
            chart_2: *Original_Uv_Charts_Chart =
                cast,no_check(*Original_Uv_Charts_Chart) index_explicit_51(
                    *charts,
                    c_
                );
            resize(*temp_points, chart_2.face_count * 3);
            {
                f: u32 = 0;
                while f < chart_2.face_count {
                    FACE: u32 = ((cast(**u32) *(index_explicit(*chart_faces, chart_2.first_face + f))).*).*;
                    for i: 0..cast(u32) 3 - 1 {
                        assign_7(
                            index_explicit_10(*temp_points, (f * 3) + i),
                            position(data.mesh, vertex_at(data.mesh, (FACE * 3) + i))
                        );
                    }
                    f += 1;
                }
            }
            compute_basis(
                make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector3(*temp_points),
                (cast(**Basis) *(index_explicit_49(*chart_basis, c_))).*
            );
            c_ += 1;
        }
    }
}

index_explicit_51 :: (using array: *Array(Original_Uv_Charts_Chart), index: u32) -> *Original_Uv_Charts_Chart {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Original_Uv_Charts_Chart) base.buffer)[index];
}

push_back :: (using array: *Array(Original_Uv_Charts_Chart), value: *Original_Uv_Charts_Chart) {
    push_back(*base, cast(*u8) ((cast(**Original_Uv_Charts_Chart) *(value)).*));
}

floodfill_faces :: (using original_uv_charts: *Original_Uv_Charts, chart: *Original_Uv_Charts_Chart) {
    IS_FACE_AREA_NEGATIVE :=
        ((cast(**float32) *(index_explicit_26(
            *data.face_uv_areas,
            ((cast(**u32) *(index_explicit(*chart_faces, chart.first_face))).*).*
        ))).*).* < 0.0;
    while true {
        new_face_added: bool = false;
        FACE_COUNT := chart.face_count;
        if 0 < FACE_COUNT {
            for f: 0..FACE_COUNT - 1 {
                SOURCE_FACE: u32 = ((cast(**u32) *(index_explicit(*chart_faces, chart.first_face + f))).*).*;
                {
                    edge_it: Mesh_Face_Edge_Iterator = ---;
                    init(*edge_it, data.mesh, SOURCE_FACE);
                    while !is_done(*edge_it) {
                        FACE := opposite_face(*edge_it);
                        if FACE == 4294967295 {
                            advance(*edge_it);
                            continue;
                        }
                        if get(*data.is_face_in_chart, FACE) {
                            advance(*edge_it);
                            continue;
                        }
                        if internal_is_zero(
                            ((cast(**float32) *(index_explicit_26(*data.face_uv_areas, FACE))).*).*,
                            K_AREA_EPSILON
                        ) {
                            advance(*edge_it);
                            continue;
                        }
                        if (((cast(**float32) *(index_explicit_26(*data.face_uv_areas, FACE))).*).* < 0.0) != IS_FACE_AREA_NEGATIVE {
                            advance(*edge_it);
                            continue;
                        }
                        uv0: *Vector2 = cast,no_check(*Vector2) texcoord_2(data.mesh, vertex0(*edge_it));
                        uv1: *Vector2 = cast,no_check(*Vector2) texcoord_2(data.mesh, vertex1(*edge_it));
                        ouv0: *Vector2 =
                            cast,no_check(*Vector2) texcoord_2(
                                data.mesh,
                                vertex_at(
                                data.mesh,
                                internal_mesh_edge_index0(opposite_edge(*edge_it))
                            )
                            );
                        ouv1: *Vector2 =
                            cast,no_check(*Vector2) texcoord_2(
                                data.mesh,
                                vertex_at(
                                data.mesh,
                                internal_mesh_edge_index1(opposite_edge(*edge_it))
                            )
                            );
                        if !internal_equal(uv0, ouv1, epsilon(data.mesh)) || !internal_equal(uv1, ouv0, epsilon(data.mesh)) {
                            advance(*edge_it);
                            continue;
                        }
                        push_back(*chart_faces, *FACE);
                        chart.face_count += 1;
                        set(*data.is_face_in_chart, FACE);
                        new_face_added = true;
                        advance(*edge_it);
                    }
                }
            }
        }
        if !new_face_added {
            break;
        }
    }
}

clear :: (using array: *Array(Original_Uv_Charts_Chart)) {
    clear(*base);
}

reset :: (using atlas: *Segment_Atlas, mesh: *Internal_Mesh, options_: *Chart_Options) {
    data.options = (options_).*;
    data.mesh = mesh;
    compute(*data);
}

compute :: (using atlas_data: *Atlas_Data) {
    FACE_COUNT := face_count(mesh);
    EDGE_COUNT := edge_count(mesh);
    resize(*edge_dihedral_angles, EDGE_COUNT);
    resize(*edge_lengths, EDGE_COUNT);
    resize(*face_areas, FACE_COUNT);
    if options.use_input_mesh_uvs {
        resize(*face_uv_areas, FACE_COUNT);
    }
    resize(*face_normals, FACE_COUNT);
    resize(*is_face_in_chart, FACE_COUNT);
    zero_out_memory(*is_face_in_chart);
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            for i_2: 0..cast(u32) 3 - 1 {
                EDGE_2 := (f * 3) + i_2;
                p0: *Vector3 =
                    cast,no_check(*Vector3) position(
                        mesh,
                        vertex_at(mesh, internal_mesh_edge_index0(EDGE_2))
                    );
                p1: *Vector3 =
                    cast,no_check(*Vector3) position(
                        mesh,
                        vertex_at(mesh, internal_mesh_edge_index1(EDGE_2))
                    );
                (ifx true { assignment_67: float32 = cast,no_check(float32) (internal_length(
                    (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(p1, p0); *temporary___g0; })
                )); (((cast(**float32) *(index_explicit_26(*edge_lengths, EDGE_2))).*).*) = assignment_67; assignment_67; });
                assert(((cast(**float32) *(index_explicit_26(*edge_lengths, EDGE_2))).*).* > 0.0);
            }
            assignment_68: float32 = compute_face_area(mesh, f);
            (((cast(**float32) *(index_explicit_26(*face_areas, f))).*).*) = assignment_68;
            assert(((cast(**float32) *(index_explicit_26(*face_areas, f))).*).* > 0.0);
            if options.use_input_mesh_uvs {
                assignment_69: float32 = compute_face_parametric_area(mesh, f);
                (((cast(**float32) *(index_explicit_26(*face_uv_areas, f))).*).*) = assignment_69;
            }
            assign_9(
                index_explicit_10(*face_normals, f),
                (ifx true { temporary___g1: Vector3 = compute_face_normal(mesh, f); *temporary___g1; })
            );
        }
    }
    if 0 < FACE_COUNT {
        for face_2: 0..FACE_COUNT - 1 {
            for i: 0..cast(u32) 3 - 1 {
                EDGE := (face_2 * 3) + i;
                OEDGE := opposite_edge(mesh, EDGE);
                if OEDGE == 4294967295 {
                    ((cast(**float32) *(index_explicit_26(*edge_dihedral_angles, EDGE))).*).* =
                        cast(float32) 3.40282347e+38;
                } else {
                    OFACE := internal_mesh_edge_face(OEDGE);
                    assignment_71: float32 =
                        (ifx true { assignment_70: float32 = cast,no_check(float32) (internal_dot(index_explicit_10(*face_normals, face_2), index_explicit_10(*face_normals, OFACE))); (((cast(**float32) *(index_explicit_26(*edge_dihedral_angles, OEDGE))).*).*) = assignment_70; assignment_70; });
                    (((cast(**float32) *(index_explicit_26(*edge_dihedral_angles, EDGE))).*).*) = assignment_71;
                }
            }
        }
    }
}

edge_count :: (using mesh: *Internal_Mesh) -> u32 {
    return size(*indices);
}

index_explicit_52 :: (using array: *Array(*Chart_Group), index: u32) -> **Chart_Group {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Chart_Group) base.buffer)[index];
}

extract :: (
    using invalid_mesh_geometry_2: *Invalid_Mesh_Geometry,
    mesh: *Internal_Mesh,
    mesh_face_groups: *Mesh_Face_Groups
) {
    clear(*faces);
    MESH_FACE_COUNT := face_count(mesh);
    {
        f_2: u32 = 0;
        while f_2 < MESH_FACE_COUNT {
            if mesh_face_groups != null && group_at(mesh_face_groups, f_2) == cast(u32) 4294967295 ||
                mesh_face_groups == null && is_face_ignored(mesh, f_2) {
                push_back(*faces, *f_2);
            }
            f_2 += 1;
        }
    }

    FACE_COUNT := size(*faces);
    resize(*indices, FACE_COUNT * 3);
    APPROX_VERTEX_COUNT: u32 =
        internal_min(
            (ifx true { temporary___g0: u32 = (FACE_COUNT * 3); *temporary___g0; }),
            (ifx true { temporary___g1: u32 = vertex_count(mesh); *temporary___g1; })
        );
    clear(*vertex_to_source_vertex_map);
    reserve(*vertex_to_source_vertex_map, APPROX_VERTEX_COUNT);
    source_vertex_to_vertex_map: Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)) = ---;
    defer deinit(*source_vertex_to_vertex_map);
    init(*source_vertex_to_vertex_map, cast(s32) INTERNAL_MEM_TAG_MESH, APPROX_VERTEX_COUNT);
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            FACE: u32 = ((cast(**u32) *(index_explicit(*faces, f))).*).*;
            for i: 0..cast(u32) 3 - 1 {
                VERTEX := vertex_at(mesh, (FACE * 3) + i);
                new_vertex := get(*source_vertex_to_vertex_map, *VERTEX);
                if new_vertex == 4294967295 {
                    new_vertex = add(*source_vertex_to_vertex_map, *VERTEX);
                    push_back(*vertex_to_source_vertex_map, *VERTEX);
                }
                assignment_72: u32 = new_vertex;
                (((cast(**u32) *(index_explicit(*indices, (f * 3) + i))).*).*) = assignment_72;
            }
        }
    }
}

group_at :: (using mesh_face_groups: *Mesh_Face_Groups, face_2: u32) -> Mesh_Face_Groups_Handle {
    return ((cast(**u32) *(index_explicit_7(*groups, face_2))).*).*;
}

resize :: (using array: *Array(*Chart_Group), new_size: u32) {
    resize(*base, new_size, true);
}

compute :: (mesh_face_groups: *Mesh_Face_Groups) {
    resize(*mesh_face_groups.groups, face_count(mesh_face_groups.mesh));
    fill_bytes(*mesh_face_groups.groups, 0xff);
    first_unassigned_face: u32 = 0;
    group: Mesh_Face_Groups_Handle = 0;
    grow_faces: Array(u32) = ---;
    defer deinit(*grow_faces);
    init(*grow_faces, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    N := face_count(mesh_face_groups.mesh);
    resize(*mesh_face_groups.next_face, N);
    while true {
        face_2: u32 = 4294967295;
        {
            f := first_unassigned_face;
            while f < N {
                if ((cast(**u32) *(index_explicit(*mesh_face_groups.groups, f))).*).* == cast(u32) 4294967295 &&
                    !is_face_ignored(mesh_face_groups.mesh, f) {
                    face_2 = f;
                    first_unassigned_face = f + 1;
                    break;
                }
                f += 1;
            }
        }
        if face_2 == 4294967295 {
            break;
        }
        assignment_73: u32 = group;
        (((cast(**u32) *(index_explicit(*mesh_face_groups.groups, face_2))).*).*) = assignment_73;
        ((cast(**u32) *(index_explicit(*mesh_face_groups.next_face, face_2))).*).* = 4294967295;
        push_back(*mesh_face_groups.first_face, *face_2);
        clear(*grow_faces);
        push_back(*grow_faces, *face_2);
        prev_face := face_2;
        group_face_count: u32 = 1;

        while true {
            if is_empty(*grow_faces) {
                break;
            }
            F: u32 = ((cast(**u32) *(back(*grow_faces))).*).*;
            pop_back(*grow_faces);
            MATERIAL := face_material(mesh_face_groups.mesh, F);
            {
                edge_it: Mesh_Face_Edge_Iterator = ---;
                init(*edge_it, mesh_face_groups.mesh, F);
                while !is_done(*edge_it) {
                    OPPOSITE_EDGE := find_edge(mesh_face_groups.mesh, vertex1(*edge_it), vertex0(*edge_it));
                    if OPPOSITE_EDGE == 4294967295 {
                        advance(*edge_it);
                        continue;
                    }
                    OPPOSITE_FACE := internal_mesh_edge_face(OPPOSITE_EDGE);
                    if is_face_ignored(mesh_face_groups.mesh, OPPOSITE_FACE) {
                        advance(*edge_it);
                        continue;
                    }
                    if face_material(mesh_face_groups.mesh, OPPOSITE_FACE) != MATERIAL {
                        advance(*edge_it);
                        continue;
                    }
                    if ((cast(**u32) *(index_explicit(*mesh_face_groups.groups, OPPOSITE_FACE))).*).* != cast(u32) 4294967295 {
                        advance(*edge_it);
                        continue;
                    }
                    assignment_74: u32 = group;
                    (((cast(**u32) *(index_explicit(*mesh_face_groups.groups, OPPOSITE_FACE))).*).*) = assignment_74;
                    ((cast(**u32) *(index_explicit(*mesh_face_groups.next_face, OPPOSITE_FACE))).*).* = 4294967295;
                    if prev_face != 4294967295 {
                        assignment_75: u32 = OPPOSITE_FACE;
                        (((cast(**u32) *(index_explicit(*mesh_face_groups.next_face, prev_face))).*).*) = assignment_75;
                    }
                    prev_face = OPPOSITE_FACE;
                    group_face_count += 1;
                    push_back(*grow_faces, *OPPOSITE_FACE);
                    advance(*edge_it);
                }
            }
        }
        push_back(*mesh_face_groups.face_count, *group_face_count);
        group += 1;
        if !(group < cast(u32) 4294967295) {
            if s_print != null {
                s_print(
                    c_string("\rASSERT: %s %s %d\n"),
                    c_string("group < kInvalid"),
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    cast(s32) 2922
                );
            }
        }
    }
}

face_material :: (using mesh: *Internal_Mesh, face_2: u32) -> u32 {
    return ifx flags & INTERNAL_MESH_FLAGS_HAS_MATERIALS != 0 then ((cast(**u32) *(index_explicit_7(*face_materials, face_2))).*).* else 4294967295;
}

index_explicit_53 :: (
    using array: *Array(Mesh_Compute_Charts_Task_Args),
    index: u32
) -> *Mesh_Compute_Charts_Task_Args {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Mesh_Compute_Charts_Task_Args) base.buffer)[index];
}

index_explicit_54 :: (using array: *Array(*Internal_Mesh), index: u32) -> **Internal_Mesh {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Internal_Mesh) base.buffer)[index];
}

index_explicit_55 :: (using array: *Array(Invalid_Mesh_Geometry), index: u32) -> *Invalid_Mesh_Geometry {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Invalid_Mesh_Geometry) base.buffer)[index];
}

index_explicit_56 :: (using array: *Array(Array(*Chart_Group)), index: u32) -> *Array(*Chart_Group) {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Array(*Chart_Group)) base.buffer)[index];
}

resize :: (using array: *Array(Mesh_Compute_Charts_Task_Args), new_size: u32) {
    resize(*base, new_size, true);
}

run_ctors :: (using array: *Array(Invalid_Mesh_Geometry)) {
    {
        i: u32 = 0;
        while i < base.size {
            (ifx true {
    cpp_transpiler_new_g68 :=
        cast(*Invalid_Mesh_Geometry) (cast(*void) (*(cast(*Invalid_Mesh_Geometry) base.buffer)[i]));
    init(cpp_transpiler_new_g68);
    cpp_transpiler_new_g68;
})
;
            i += 1;
        }
    }
}

resize :: (using array: *Array(Invalid_Mesh_Geometry), new_size: u32) {
    resize(*base, new_size, true);
}

run_ctors :: (using array: *Array(Array(*Chart_Group))) {
    {
        i: u32 = 0;
        while i < base.size {
            (ifx true {
    cpp_transpiler_new_g69 := cast(*Array(*Chart_Group)) (cast(*void) (*(cast(*Array(*Chart_Group)) base.buffer)[i]));
    init(cpp_transpiler_new_g69, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    cpp_transpiler_new_g69;
})
;
            i += 1;
        }
    }
}

resize :: (using array: *Array(Array(*Chart_Group)), new_size: u32) {
    resize(*base, new_size, true);
}

size :: (using array: *Array(Array(*Chart_Group))) -> u32 {
    return base.size;
}

clear :: (using array: *Array(*Chart_Group)) {
    clear(*base);
}

deinit :: (using chart_group: *Chart_Group) {
    cpp_transpiler_subobject_cleanup_g70: bool = ---;
    defer deinit(*face_to_source_face_map);
    cpp_transpiler_subobject_cleanup_g71: bool = ---;
    defer deinit(*charts);
    {
        i: u32 = 0;
        while i < size(*charts) {
            deinit((cast(**Param_Chart) index_explicit_39(*charts, i)).*);
            internal_realloc(
                cast(*void) ((cast(**Param_Chart) index_explicit_39(*charts, i)).*),
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                7506
            );
            i += 1;
        }
    }
}

is_empty :: (using array: *Array(Array(*Chart_Group))) -> bool {
    return base.size == 0;
}

push_back :: (using array: *Array(*Uv_Mesh), value: **Uv_Mesh) {
    push_back(*base, cast(*u8) (cast(**Uv_Mesh) value));
}

push_back :: (using array: *Array(*Uv_Mesh_Instance), value: **Uv_Mesh_Instance) {
    push_back(*base, cast(*u8) (cast(**Uv_Mesh_Instance) value));
}

deinit :: (using progress: *Progress) {
    if func != null {
        if !func(category, 100, user_data) {
            assign_in_xatlas(*cancel, true);
        }
    }
}

is_empty :: (using array: *Array(*Uv_Mesh)) -> bool {
    return base.size == 0;
}

add_mesh :: (using atlas: *Param_Atlas, mesh: *Internal_Mesh) {
    push_back(*meshes, *mesh);
}

push_back :: (using array: *Array(*Internal_Mesh), value: **Internal_Mesh) {
    push_back(*base, cast(*u8) (cast(**Internal_Mesh) value));
}

push_back :: (using array: *Array(*Mesh_Polygon_Mapping), value: **Mesh_Polygon_Mapping) {
    push_back(*base, cast(*u8) (cast(**Mesh_Polygon_Mapping) value));
}

push_back_2 :: (using array: *Array(*Internal_Mesh), value: **Internal_Mesh) {
    push_back(*base, cast(*u8) (cast(**Internal_Mesh) value));
}

triangulate_polygon :: (
    using triangulator: *Triangulator,
    vertices_2: Const_Array_View(Vector3),
    input_indices: Const_Array_View(u32),
    output_indices: *Array(u32)
) {
    local_vertices_2: Const_Array_View(Vector3) = vertices_2;
    local_input_indices: Const_Array_View(u32) = input_indices;
    clear(*polygon_vertices);
    reserve(*polygon_vertices, local_input_indices.length);
    clear(output_indices);
    if local_input_indices.length == 3 {
        push_back(output_indices, index_explicit_12(*local_input_indices, 0));
        push_back(output_indices, index_explicit_12(*local_input_indices, 1));
        push_back(output_indices, index_explicit_12(*local_input_indices, 2));
    } else {
        basis: Basis = ---;
        init(*basis);
        assign_9(
            *basis.normal,
            (ifx true { temporary___g4: Vector3 = internal_normalize(
            (ifx true { temporary___g2: Vector3 = internal_cross(
            (ifx true { temporary___g0: Vector3 = internal_operator_in_xatlas_2(
            index_explicit_14(*local_vertices_2, ((cast(**u32) *(index_explicit_12(*local_input_indices, 1))).*).*),
            index_explicit_14(*local_vertices_2, ((cast(**u32) *(index_explicit_12(*local_input_indices, 0))).*).*)
        ); *temporary___g0; }),
            (ifx true { temporary___g1: Vector3 = internal_operator_in_xatlas_2(
            index_explicit_14(*local_vertices_2, ((cast(**u32) *(index_explicit_12(*local_input_indices, 2))).*).*),
            index_explicit_14(*local_vertices_2, ((cast(**u32) *(index_explicit_12(*local_input_indices, 1))).*).*)
        ); *temporary___g1; })
        ); *temporary___g2; })
        ); *temporary___g4; })
        );
        assign_9(
            *basis.tangent,
            (ifx true { temporary___g3: Vector3 = compute_tangent(*basis.normal); *temporary___g3; })
        );
        assign_9(
            *basis.bitangent,
            (ifx true { temporary___g6: Vector3 = compute_bitangent(*basis.normal, *basis.tangent); *temporary___g6; })
        );
        EDGE_COUNT := local_input_indices.length;
        clear(*polygon_points);
        reserve(*polygon_points, EDGE_COUNT);
        clear(*polygon_angles);
        reserve(*polygon_angles, EDGE_COUNT);
        {
            i_2: u32 = 0;
            while i_2 < local_input_indices.length {
                push_back(
                    *polygon_vertices,
                    (ifx true { temporary___g5: s32 = cast,no_check(s32) (((cast(**u32) *(index_explicit_12(*local_input_indices, i_2))).*).*); *temporary___g5; })
                );
                pos: *Vector3 =
                    cast,no_check(*Vector3) index_explicit_14(
                        *local_vertices_2,
                        ((cast(**u32) *(index_explicit_12(*local_input_indices, i_2))).*).*
                    );
                push_back(
                    *polygon_points,
                    (ifx true { temporary___g8: Vector2 = make_vector2(internal_dot(*basis.tangent, pos), internal_dot(*basis.bitangent, pos)); *temporary___g8; })
                );
                i_2 += 1;
            }
        }
        resize(*polygon_angles, EDGE_COUNT);
        while size(*polygon_vertices) > 2 {
            SIZE := size(*polygon_vertices);

            min_angle := K_PI2;
            best_ear: u32 = 0;
            best_is_valid: bool = false;
            if 0 < SIZE {
                for i: 0..SIZE - 1 {
                    i0 := i;
                    i1 := (i + 1) % SIZE;
                    i2 := (i + 2) % SIZE;
                    p0 := ((cast(**Vector2) *(index_explicit_4(*polygon_points, i0))).*).*;
                    p1 := ((cast(**Vector2) *(index_explicit_4(*polygon_points, i1))).*).*;
                    p2 := ((cast(**Vector2) *(index_explicit_4(*polygon_points, i2))).*).*;
                    d :=
                        internal_clamp(
                            (ifx true { temporary___g12: float32 = (internal_dot(
                            (ifx true { temporary___g7: Vector2 = internal_operator(*p0, *p1); *temporary___g7; }),
                            (ifx true { temporary___g9: Vector2 = internal_operator(*p2, *p1); *temporary___g9; })
                        ) / (internal_length(
                            (ifx true { temporary___g10: Vector2 = internal_operator(*p0, *p1); *temporary___g10; })
                        ) * internal_length(
                            (ifx true { temporary___g11: Vector2 = internal_operator(*p2, *p1); *temporary___g11; })
                        ))); *temporary___g12; }),
                            (ifx true { temporary___g13: float32 = -1.0; *temporary___g13; }),
                            (ifx true { temporary___g15: float32 = 1.0; *temporary___g15; })
                        );
                    angle := acosf(d);
                    area_2 := internal_triangle_area(*p0, *p1, *p2);
                    if area_2 < 0.0 {
                        angle = K_PI2 - angle;
                    }
                    assignment_76: float32 = angle;
                    (((cast(**float32) *(index_explicit_26(*polygon_angles, i1))).*).*) = assignment_76;
                    if angle < min_angle || !best_is_valid {
                        valid: bool = true;
                        if 0 < SIZE {
                            for j: 0..SIZE - 1 {
                                if j == i0 || j == i1 || j == i2 {
                                    continue;
                                }
                                p := ((cast(**Vector2) *(index_explicit_4(*polygon_points, j))).*).*;
                                if point_in_triangle(*p, *p0, *p1, *p2) {
                                    valid = false;
                                    break;
                                }
                            }
                        }
                        if valid || !best_is_valid {
                            min_angle = angle;
                            best_ear = i1;
                            best_is_valid = valid;
                        }
                    }
                }
            }

            I0 := (best_ear + SIZE - 1) % SIZE;
            I1 := (best_ear + 0) % SIZE;
            I2 := (best_ear + 1) % SIZE;
            push_back(
                output_indices,
                (ifx true { temporary___g16: u32 = cast,no_check(u32) (((cast(**s32) *(index_explicit_48(*polygon_vertices, I0))).*).*); *temporary___g16; })
            );
            push_back(
                output_indices,
                (ifx true { temporary___g17: u32 = cast,no_check(u32) (((cast(**s32) *(index_explicit_48(*polygon_vertices, I1))).*).*); *temporary___g17; })
            );
            push_back(
                output_indices,
                (ifx true { temporary___g18: u32 = cast,no_check(u32) (((cast(**s32) *(index_explicit_48(*polygon_vertices, I2))).*).*); *temporary___g18; })
            );
            remove_at(*polygon_vertices, I1);
            remove_at(*polygon_points, I1);
            remove_at(*polygon_angles, I1);
        }
    }
}

remove_at :: (using array: *Array(float32), index: u32) {
    remove_at(*base, index);
}

remove_at :: (using array: *Array(Vector2), index: u32) {
    remove_at(*base, index);
}

remove_at :: (using array: *Array(s32), index: u32) {
    remove_at(*base, index);
}

point_in_triangle :: (p: *Vector2, a: *Vector2, b: *Vector2, c_: *Vector2) -> bool {
    return internal_triangle_area(a, b, p) >= K_AREA_EPSILON && internal_triangle_area(b, c_, p) >= K_AREA_EPSILON && internal_triangle_area(c_, a, p) >= K_AREA_EPSILON;
}

push_back :: (using array: *Array(s32), value: *s32) {
    push_back(*base, cast(*u8) ((cast(**s32) *(value)).*));
}

reserve :: (using array: *Array(float32), desired_size: u32) {
    reserve(*base, desired_size);
}

clear :: (using array: *Array(float32)) {
    clear(*base);
}

reserve :: (using array: *Array(s32), desired_size: u32) {
    reserve(*base, desired_size);
}

clear :: (using array: *Array(s32)) {
    clear(*base);
}

copy_from :: (using array: *Array(u8), data_40: *u8, length: u32) {
    copy_from(*base, data_40, length);
}

copy_from :: (using array_base: *Array_Base, data_40: *u8, length: u32) {
    assert(data_40 != null);
    assert(length > 0);
    resize(array_base, length, true);
    if buffer != null && data_40 != null && length > 0 {
        copy_memory(buffer, data_40, cast,no_check(u64) (length * element_size));
    }
}

decode_position :: (mesh_decl: *Mesh_Decl, index: u32) -> Vector3 {
    assert(mesh_decl.vertex_position_data != null);
    assert(mesh_decl.vertex_position_stride > 0);
    return (cast(*Vector3) (*(cast(*u8) mesh_decl.vertex_position_data)[mesh_decl.vertex_position_stride * index])).*;
}

decode_uv :: (mesh_decl: *Mesh_Decl, index: u32) -> Vector2 {
    assert(mesh_decl.vertex_uv_data != null);
    assert(mesh_decl.vertex_uv_stride > 0);
    return (cast(*Vector2) (*(cast(*u8) mesh_decl.vertex_uv_data)[mesh_decl.vertex_uv_stride * index])).*;
}

decode_normal :: (mesh_decl: *Mesh_Decl, index: u32) -> Vector3 {
    assert(mesh_decl.vertex_normal_data != null);
    assert(mesh_decl.vertex_normal_stride > 0);
    return (cast(*Vector3) (*(cast(*u8) mesh_decl.vertex_normal_data)[mesh_decl.vertex_normal_stride * index])).*;
}

set_max_value :: (using progress: *Progress, _max_value: u32) {
    assign_in_xatlas_3(cast(*struct_atomic_base_unsigned_int) *max_value, _max_value);
    update(progress);
}

assign_in_xatlas_3 :: (
    using struct_atomic_base_unsigned_int_: *struct_atomic_base_unsigned_int,
    _i: std_atomic_base_unsigned_int_int_type
) -> std_atomic_base_unsigned_int_int_type {
    store(struct_atomic_base_unsigned_int_, _i, STD_MEMORY_ORDER_SEQ_CST);
    return _i;
}

store :: inline (
    using struct_atomic_base_unsigned_int_: *struct_atomic_base_unsigned_int,
    _i: std_atomic_base_unsigned_int_int_type,
    m: std_memory_order
) {
    b := std_operator(m, STD_MEMORY_ORDER_MASK);
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_ACQUIRE)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                490,
                c_string("void std::__atomic_base<unsigned int>::store(__int_type, memory_order) [_ITp = unsigned int]"),
                c_string("__b != memory_order_acquire")
            );
        }
        if !(false) break;
    }
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_ACQ_REL)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                491,
                c_string("void std::__atomic_base<unsigned int>::store(__int_type, memory_order) [_ITp = unsigned int]"),
                c_string("__b != memory_order_acq_rel")
            );
        }
        if !(false) break;
    }
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_CONSUME)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                492,
                c_string("void std::__atomic_base<unsigned int>::store(__int_type, memory_order) [_ITp = unsigned int]"),
                c_string("__b != memory_order_consume")
            );
        }
        if !(false) break;
    }

    c_transpiler_atomic_store(*i, _i);
}

deinit :: (using context_value: *Context) {
    cpp_transpiler_subobject_cleanup_g72: bool = ---;
    defer deinit(*param_atlas);
    cpp_transpiler_subobject_cleanup_g73: bool = ---;
    defer deinit_2(*meshes);
    cpp_transpiler_subobject_cleanup_g74: bool = ---;
    defer deinit(*mesh_polygon_mappings);
    cpp_transpiler_subobject_cleanup_g75: bool = ---;
    defer deinit(*uv_meshes);
    cpp_transpiler_subobject_cleanup_g76: bool = ---;
    defer deinit(*uv_mesh_instances);
}

deinit :: (using uv_mesh_instance: *Uv_Mesh_Instance) {
    cpp_transpiler_subobject_cleanup_g77: bool = ---;
    defer deinit(*texcoords);
}

deinit :: (using uv_mesh: *Uv_Mesh) {
    cpp_transpiler_subobject_cleanup_g78: bool = ---;
    defer deinit(*face_ignore);
    cpp_transpiler_subobject_cleanup_g79: bool = ---;
    defer deinit(*face_materials);
    cpp_transpiler_subobject_cleanup_g80: bool = ---;
    defer deinit(*indices);
    cpp_transpiler_subobject_cleanup_g81: bool = ---;
    defer deinit(*texcoords);
    cpp_transpiler_subobject_cleanup_g82: bool = ---;
    defer deinit(*charts);
    cpp_transpiler_subobject_cleanup_g83: bool = ---;
    defer deinit(*vertex_to_chart_map);
}

deinit :: (using uv_mesh_chart: *Uv_Mesh_Chart) {
    cpp_transpiler_subobject_cleanup_g84: bool = ---;
    defer deinit(*faces);
    cpp_transpiler_subobject_cleanup_g85: bool = ---;
    defer deinit(*indices);
}

deinit :: (using mesh_polygon_mapping: *Mesh_Polygon_Mapping) {
    cpp_transpiler_subobject_cleanup_g86: bool = ---;
    defer deinit(*face_vertex_count);
    cpp_transpiler_subobject_cleanup_g87: bool = ---;
    defer deinit(*triangle_to_polygon_map);
    cpp_transpiler_subobject_cleanup_g88: bool = ---;
    defer deinit(*triangle_to_polygon_indices_map);
}

size :: (using array: *Array(*Mesh_Polygon_Mapping)) -> u32 {
    return base.size;
}

index_explicit_57 :: (using array: *Array(*Internal_Mesh), index: u32) -> **Internal_Mesh {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(**Internal_Mesh) base.buffer)[index];
}

deinit :: (using task_scheduler: *Task_Scheduler) {
    cpp_transpiler_subobject_cleanup_g89: bool = ---;
    defer deinit(*groups);
    {
        i: u32 = 0;
        while i < size(*groups) {
            destroy_group(task_scheduler, Task_Group_Handle.{value = i});
            i += 1;
        }
    }
}

deinit :: (using chart: *Pack_Chart) {
    cpp_transpiler_subobject_cleanup_g90: bool = ---;
    defer deinit(*unique_vertices);
    cpp_transpiler_subobject_cleanup_g91: bool = ---;
    defer deinit(*faces);
}

deinit :: (using bit_image: *Bit_Image) {
    cpp_transpiler_subobject_cleanup_g92: bool = ---;
    defer deinit(*data);
}

deinit :: (using atlas_image: *Atlas_Image) {
    cpp_transpiler_subobject_cleanup_g93: bool = ---;
    defer deinit(*data);
}

size :: (using array: *Array(*Atlas_Image)) -> u32 {
    return base.size;
}

run_dtors :: (using array: *Array(Invalid_Mesh_Geometry)) {
    {
        i: u32 = 0;
        while i < base.size {
            deinit(*(cast(*Invalid_Mesh_Geometry) base.buffer)[i]);
            i += 1;
        }
    }
}

deinit :: (using invalid_mesh_geometry_2: *Invalid_Mesh_Geometry) {
    cpp_transpiler_subobject_cleanup_g94: bool = ---;
    defer deinit(*faces);
    cpp_transpiler_subobject_cleanup_g95: bool = ---;
    defer deinit(*indices);
    cpp_transpiler_subobject_cleanup_g96: bool = ---;
    defer deinit(*vertex_to_source_vertex_map);
}

run_dtors :: (using array: *Array(Array(*Chart_Group))) {
    {
        i: u32 = 0;
        while i < base.size {
            deinit(*(cast(*Array(*Chart_Group)) base.buffer)[i]);
            i += 1;
        }
    }
}

deinit :: (using array: *Array(*Chart_Group)) {
    cpp_transpiler_subobject_cleanup_g97: bool = ---;
    defer deinit(*base);
}

texcoords :: (using piecewise_param: *Piecewise_Param) -> Const_Array_View(Vector2) {
    return make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2(*texcoords);
}

chart_faces :: (using piecewise_param: *Piecewise_Param) -> Const_Array_View(u32) {
    return make_struct_xatlas_internal_const_array_view_unsigned_int(*patch);
}

get :: (using thread_local: *Thread_Local(Chart_Ctor_Buffers)) -> *Chart_Ctor_Buffers {
    return *array[current_thread_index()];
}

first_colocal_vertex :: (using mesh: *Internal_Mesh, vertex: u32) -> u32 {
    assert(size(*first_colocal_vertex) == size(*positions));
    return ((cast(**u32) *(index_explicit_7(*first_colocal_vertex, vertex))).*).*;
}

copy_from :: (using array: *Array(u32), data_40: *u32, length: u32) {
    copy_from(*base, cast(*u8) data_40, length);
}

index_explicit_58 :: (using array_view: *Array_View(*Uv_Mesh), index: u32) -> **Uv_Mesh {
    assert(index < length);
    return *data[index];
}

index_explicit_59 :: (
    using array: *Array(Compute_Uv_Mesh_Charts_Task_Args),
    index: u32
) -> *Compute_Uv_Mesh_Charts_Task_Args {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*Compute_Uv_Mesh_Charts_Task_Args) base.buffer)[index];
}

resize :: (using array: *Array(Compute_Uv_Mesh_Charts_Task_Args), new_size: u32) {
    resize(*base, new_size, true);
}

run :: (using compute_uv_mesh_charts_task: *Compute_Uv_Mesh_Charts_Task) {
    VERTEX_COUNT := size(*mesh.texcoords);
    INDEX_COUNT := size(*mesh.indices);
    FACE_COUNT := INDEX_COUNT / 3;

    resize(*mesh.vertex_to_chart_map, VERTEX_COUNT);
    fill(*mesh.vertex_to_chart_map, (ifx true { temporary___g0: u32 = cast(u32) 4294967295; *temporary___g0; }));

    if 0 < INDEX_COUNT {
        for i_2: 0..INDEX_COUNT - 1 {
            add(
                *uv_to_edge_map,
                index_explicit_4(*mesh.texcoords, ((cast(**u32) *(index_explicit(*mesh.indices, i_2))).*).*)
            );
        }
    }

    zero_out_memory(*face_assigned);
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            if operator_bool(*progress.cancel) {
                return;
            }
            increment(progress, 1);

            CHART_INDEX := size(*mesh.charts);
            if !can_add_face_to_chart(compute_uv_mesh_charts_task, CHART_INDEX, f) {
                continue;
            }

            chart :=
                cast(*Uv_Mesh_Chart) (cast(*void) (cast(*Uv_Mesh_Chart) internal_realloc(
                    null,
                    56,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    6228
                )));
            init(chart);
            push_back(*mesh.charts, *chart);
            chart.material =
                ifx is_empty(*mesh.face_materials) then 0 else ((cast(**u32) *(index_explicit(*mesh.face_materials, f))).*).*;
            add_face_to_chart(compute_uv_mesh_charts_task, CHART_INDEX, f);

            f2: u32 = 0;
            while true {
                new_face_assigned: bool = false;
                FACE_COUNT2 := size(*chart.faces);
                while f2 < FACE_COUNT2 {
                    FACE: u32 = ((cast(**u32) *(index_explicit(*chart.faces, f2))).*).*;
                    for i: 0..cast(u32) 3 - 1 {
                        uv: *Vector2 =
                            cast,no_check(*Vector2) index_explicit_4(
                                *mesh.texcoords,
                                ((cast(**u32) *(index_explicit(*mesh.indices, (FACE * 3) + i))).*).*
                            );
                        edge_2 := get(*uv_to_edge_map, uv);
                        while edge_2 != 4294967295 {
                            NEW_FACE := edge_2 / 3;
                            if can_add_face_to_chart(compute_uv_mesh_charts_task, CHART_INDEX, NEW_FACE) {
                                add_face_to_chart(compute_uv_mesh_charts_task, CHART_INDEX, NEW_FACE);
                                new_face_assigned = true;
                            }
                            edge_2 = get_next(*uv_to_edge_map, uv, edge_2);
                        }
                    }
                    f2 += 1;
                }
                if !new_face_assigned {
                    break;
                }
            }
        }
    }
}

get :: (using hash_map: *Hash_Map(Vector2, Hash(Vector2), Equal(Vector2)), key: *Vector2) -> u32 {
    if slots == null {
        return 4294967295;
    }
    return find(hash_map, key, slots[compute_hash(hash_map, key)]);
}

compute_hash :: (using hash_map: *Hash_Map(Vector2, Hash(Vector2), Equal(Vector2)), key: *Vector2) -> u32 {
    hash: Hash(Vector2) = ---;
    return call_7(*hash, key) & (num_slots - 1);
}

call_7 :: (using hash: *Hash(Vector2), k: *Vector2) -> u32 {
    return internal_hash(k, 5381);
}

internal_hash :: (t: *Vector2, h: u32) -> u32 {
    return internal_sdbm_hash(cast(*void) ((cast(**Vector2) *(t)).*), 8, h);
}

find :: (using hash_map: *Hash_Map(Vector2, Hash(Vector2), Equal(Vector2)), key: *Vector2, current_2: u32) -> u32 {
    equal: Equal(Vector2) = ---;
    while current_2 != 4294967295 {
        if call_8(*equal, index_explicit_18(*keys, current_2), key) {
            return current_2;
        }
        current_2 = ((cast(**u32) *(index_explicit_7(*next, current_2))).*).*;
    }
    return current_2;
}

call_8 :: (using equal: *Equal(Vector2), k0: *Vector2, k1: *Vector2) -> bool {
    return equals_in_xatlas_2(k0, k1);
}

equals_in_xatlas_2 :: (a: *Vector2, b: *Vector2) -> bool {
    return a.x == b.x && a.y == b.y;
}

get_next :: (using hash_map: *Hash_Map(Vector2, Hash(Vector2), Equal(Vector2)), key: *Vector2, current_2: u32) -> u32 {
    return find(hash_map, key, ((cast(**u32) *(index_explicit_7(*next, current_2))).*).*);
}

add_face_to_chart :: (using compute_uv_mesh_charts_task: *Compute_Uv_Mesh_Charts_Task, chart_index: u32, face_2: u32) {
    chart: *Uv_Mesh_Chart =
        cast,no_check(*Uv_Mesh_Chart) ((cast(**Uv_Mesh_Chart) index_explicit_36(*mesh.charts, chart_index)).*);
    set(*face_assigned, face_2);
    push_back(*chart.faces, *face_2);
    for i: 0..cast(u32) 3 - 1 {
        VERTEX: u32 = ((cast(**u32) *(index_explicit(*mesh.indices, (face_2 * 3) + i))).*).*;
        assignment_77: u32 = chart_index;
        (((cast(**u32) *(index_explicit(*mesh.vertex_to_chart_map, VERTEX))).*).*) = assignment_77;
        push_back(*chart.indices, *VERTEX);
    }
}

can_add_face_to_chart :: (
    using compute_uv_mesh_charts_task: *Compute_Uv_Mesh_Charts_Task,
    chart_index: u32,
    face_2: u32
) -> bool {
    if get(*face_assigned, face_2) {
        return false;
    }
    if get(*mesh.face_ignore, face_2) {
        return false;
    }
    if !is_empty(*mesh.face_materials) && chart_index < size(*mesh.charts) {
        if ((cast(**u32) *(index_explicit(*mesh.face_materials, face_2))).*).* != ((cast(**Uv_Mesh_Chart) index_explicit_36(*mesh.charts, chart_index)).*).material {
            return false;
        }
    }
    for i: 0..cast(u32) 3 - 1 {
        VERTEX: u32 = ((cast(**u32) *(index_explicit(*mesh.indices, (face_2 * 3) + i))).*).*;
        if ((cast(**u32) *(index_explicit(*mesh.vertex_to_chart_map, VERTEX))).*).* != 4294967295 &&
            ((cast(**u32) *(index_explicit(*mesh.vertex_to_chart_map, VERTEX))).*).* != chart_index {
            return false;
        }
    }
    return true;
}

push_back :: (using array: *Array(*Uv_Mesh_Chart), value: **Uv_Mesh_Chart) {
    push_back(*base, cast(*u8) (cast(**Uv_Mesh_Chart) value));
}

add :: (hash_map: *Hash_Map(Vector2, Hash(Vector2), Equal(Vector2)), key: *Vector2) -> u32 {
    if hash_map.slots == null {
        alloc(hash_map);
    }
    HASH := compute_hash(hash_map, key);
    push_back(*hash_map.keys, key);
    push_back(*hash_map.next, *hash_map.slots[HASH]);
    hash_map.slots[HASH] = size(*hash_map.next) - 1;
    return size(*hash_map.keys) - 1;
}

alloc :: (using hash_map: *Hash_Map(Vector2, Hash(Vector2), Equal(Vector2))) {
    assert(size > 0);
    num_slots = internal_next_power_of_two(size);
    min_num_slots := cast,no_check(u32) (size * 1.3);
    if num_slots < min_num_slots {
        num_slots = internal_next_power_of_two(min_num_slots);
    }
    slots =
        cast(*u32) internal_realloc(
            null,
            4 * cast(u64) num_slots,
            mem_tag,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1995
        );
    {
        i: u32 = 0;
        while i < num_slots {
            slots[i] = 4294967295;
            i += 1;
        }
    }
    reserve(*keys, size);
    reserve(*next, size);
}

fill :: (using array: *Array(u32), value: *u32) {
    buffer := cast(*u32) base.buffer;
    {
        i: u32 = 0;
        while i < base.size {
            buffer[i] = value.*;
            i += 1;
        }
    }
}

compute_unit_inward_normals :: (using triangle: *Triangle) {
    assign(*n1, (ifx true { temporary___g0: Vector2 = internal_operator(*v1, *v2); *temporary___g0; }));
    assign(*n1, (ifx true { temporary___g1: Vector2 = make_vector2(-n1.y, n1.x); *temporary___g1; }));
    assign(
        *n1,
        (ifx true { temporary___g2: Vector2 = internal_operator(*n1, 1.0 /
        sqrtf(internal_dot(*n1, *n1))); *temporary___g2; })
    );
    assign(*n2, (ifx true { temporary___g4: Vector2 = internal_operator(*v2, *v3); *temporary___g4; }));
    assign(*n2, (ifx true { temporary___g3: Vector2 = make_vector2(-n2.y, n2.x); *temporary___g3; }));
    assign(
        *n2,
        (ifx true { temporary___g6: Vector2 = internal_operator(*n2, 1.0 /
        sqrtf(internal_dot(*n2, *n2))); *temporary___g6; })
    );
    assign(*n3, (ifx true { temporary___g5: Vector2 = internal_operator(*v3, *v1); *temporary___g5; }));
    assign(*n3, (ifx true { temporary___g8: Vector2 = make_vector2(-n3.y, n3.x); *temporary___g8; }));
    assign(
        *n3,
        (ifx true { temporary___g7: Vector2 = internal_operator(*n3, 1.0 /
        sqrtf(internal_dot(*n3, *n3))); *temporary___g7; })
    );
}

flip_backface :: (using triangle: *Triangle) {
    if (v3.x - v1.x) * (v2.y - v1.y) - (v3.y - v1.y) * (v2.x - v1.x) < 0 {
        hv := v1;
        assign_3(*v1, *v2);
        assign_3(*v2, *hv);
    }
}

deinit :: (using bounding_box2_d: *Bounding_Box2_D) {
    cpp_transpiler_subobject_cleanup_g98: bool = ---;
    defer deinit(*boundary_vertices);
    cpp_transpiler_subobject_cleanup_g99: bool = ---;
    defer deinit(*coords);
    cpp_transpiler_subobject_cleanup_g100: bool = ---;
    defer deinit(*top);
    cpp_transpiler_subobject_cleanup_g101: bool = ---;
    defer deinit(*bottom);
    cpp_transpiler_subobject_cleanup_g102: bool = ---;
    defer deinit(*hull);
    cpp_transpiler_subobject_cleanup_g103: bool = ---;
    defer deinit(*radix);
}

deinit :: (using atlas: *Segment_Atlas) {
    cpp_transpiler_subobject_cleanup_g104: bool = ---;
    defer deinit(*data);
    cpp_transpiler_subobject_cleanup_g105: bool = ---;
    defer deinit(*original_uv_charts);
    cpp_transpiler_subobject_cleanup_g106: bool = ---;
    defer deinit(*planar_charts);
    cpp_transpiler_subobject_cleanup_g107: bool = ---;
    defer deinit(*clustered_charts);
}

deinit :: (using piecewise_param: *Piecewise_Param) {
    cpp_transpiler_subobject_cleanup_g108: bool = ---;
    defer deinit(*texcoords);
    cpp_transpiler_subobject_cleanup_g109: bool = ---;
    defer deinit(*face_in_any_patch);
    cpp_transpiler_subobject_cleanup_g110: bool = ---;
    defer deinit(*candidates);
    cpp_transpiler_subobject_cleanup_g111: bool = ---;
    defer deinit(*face_to_candidate);
    cpp_transpiler_subobject_cleanup_g112: bool = ---;
    defer deinit(*patch);
    cpp_transpiler_subobject_cleanup_g113: bool = ---;
    defer deinit(*face_in_patch);
    cpp_transpiler_subobject_cleanup_g114: bool = ---;
    defer deinit(*vertex_in_patch);
    cpp_transpiler_subobject_cleanup_g115: bool = ---;
    defer deinit(*face_invalid);
    cpp_transpiler_subobject_cleanup_g116: bool = ---;
    defer deinit(*boundary_grid);
    cpp_transpiler_subobject_cleanup_g117: bool = ---;
    defer deinit(*new_boundary_edges);
    cpp_transpiler_subobject_cleanup_g118: bool = ---;
    defer deinit(*ignore_boundary_edges);
}

deinit :: (using chart_ctor_buffers: *Chart_Ctor_Buffers) {
    cpp_transpiler_subobject_cleanup_g119: bool = ---;
    defer deinit(*chart_mesh_indices);
    cpp_transpiler_subobject_cleanup_g120: bool = ---;
    defer deinit(*unified_mesh_indices);
}

deinit :: (using uniform_grid2: *Uniform_Grid2) {
    cpp_transpiler_subobject_cleanup_g121: bool = ---;
    defer deinit(*edges);
    cpp_transpiler_subobject_cleanup_g122: bool = ---;
    defer deinit(*cell_data_offsets);
    cpp_transpiler_subobject_cleanup_g123: bool = ---;
    defer deinit(*cell_data);
    cpp_transpiler_subobject_cleanup_g124: bool = ---;
    defer deinit(*potential_edges);
    cpp_transpiler_subobject_cleanup_g125: bool = ---;
    defer deinit(*traversed_cell_offsets);
}

clear :: inline (using atomic_flag_: *atomic_flag, m: std_memory_order) {
    b := std_operator(m, STD_MEMORY_ORDER_MASK);
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_CONSUME)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                286,
                c_string("void std::atomic_flag::clear(memory_order)"),
                c_string("__b != memory_order_consume")
            );
        }
        if !(false) break;
    }
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_ACQUIRE)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                287,
                c_string("void std::atomic_flag::clear(memory_order)"),
                c_string("__b != memory_order_acquire")
            );
        }
        if !(false) break;
    }
    while true {
        if cast,no_check(s64) (!(b != STD_MEMORY_ORDER_ACQ_REL)) != 0 {
            std_glibcxx_assert_fail(
                c_string("/../lib64/gcc/x86_64-pc-linux-gnu/16/../../../../include/c++/16/bits/atomic_base.h"),
                288,
                c_string("void std::atomic_flag::clear(memory_order)"),
                c_string("__b != memory_order_acq_rel")
            );
        }
        if !(false) break;
    }

    (ifx true { c_transpiler_flag_78 := cast(*u8) (cast(*s8) (*((cast(*atomic_flag_base) atomic_flag_).i))); c_transpiler_flag_order_78 := (m); atomic_store(c_transpiler_flag_78, cast(u8) 0); });
}

test_and_set :: inline (using atomic_flag_: *atomic_flag, m: std_memory_order) -> bool {
    return ifx true { c_transpiler_flag_79 := cast(*u8) (cast(*s8) (*((cast(*atomic_flag_base) atomic_flag_).i))); c_transpiler_flag_order_79 := (m); atomic_exchange(c_transpiler_flag_79, cast(u8) 1) != 0; };
}

reserve :: (using array: *Array(bool), desired_size: u32) {
    reserve(*base, desired_size);
}

reset :: (using kiss_rng: *KISS_Rng) {
    x = 123456789;
    y = 362436000;
    z = 521288629;
    c = 7654321;
}

max_dimension :: (using aabb: *AABB) -> u32 {
    EXTENT := internal_operator_in_xatlas_2(*max, *min);
    result: u32 = 0;
    if EXTENT.y > EXTENT.x {
        result = 1;
        if EXTENT.z > EXTENT.y {
            result = 2;
        }
    } else if EXTENT.z > EXTENT.x {
        result = 2;
    }
    return result;
}

index_explicit_60 :: (using array: *Array(BVH_Node), index: u32) -> *BVH_Node {
    assert(index < base.size);
    assert(base.buffer != null);
    return *(cast(*BVH_Node) base.buffer)[index];
}

push_back :: (using array: *Array(BVH_Node), value: *BVH_Node) {
    push_back(*base, cast(*u8) ((cast(**BVH_Node) *(value)).*));
}

expand_to_include :: (using aabb: *AABB, p: *Vector3) {
    assign_9(*min, (ifx true { temporary___g0: Vector3 = internal_min(*min, p); *temporary___g0; }));
    assign_9(*max, (ifx true { temporary___g1: Vector3 = internal_max(*max, p); *temporary___g1; }));
}

internal_max :: (a: *Vector3, b: *Vector3) -> Vector3 {
    return make_vector3(internal_max(*a.x, *b.x), internal_max(*a.y, *b.y), internal_max(*a.z, *b.z));
}

internal_min :: (a: *Vector3, b: *Vector3) -> Vector3 {
    return make_vector3(internal_min(*a.x, *b.x), internal_min(*a.y, *b.y), internal_min(*a.z, *b.z));
}

expand_to_include :: (using aabb_2: *AABB, aabb: *AABB) {
    assign_9(*min, (ifx true { temporary___g0: Vector3 = internal_min(*min, *aabb.min); *temporary___g0; }));
    assign_9(*max, (ifx true { temporary___g1: Vector3 = internal_max(*max, *aabb.max); *temporary___g1; }));
}

size :: (using array: *Array(AABB)) -> u32 {
    return base.size;
}

reserve :: (using array: *Array(BVH_Node), desired_size: u32) {
    reserve(*base, desired_size);
}

is_empty :: (using array: *Array(AABB)) -> bool {
    return base.size == 0;
}

data :: (using array: *Array(float32)) -> *float32 {
    return cast(*float32) base.buffer;
}

data :: (using array: *Array(Vector3)) -> *Vector3 {
    return cast(*Vector3) base.buffer;
}

data :: (using array: *Array(*Uv_Mesh)) -> **Uv_Mesh {
    return cast(**Uv_Mesh) base.buffer;
}

expand :: (using aabb: *AABB, amount: float32) {
    subtract_assign_2(*min, (ifx true { temporary___g0: Vector3 = make_vector3(amount); *temporary___g0; }));
    add_assign(*max, (ifx true { temporary___g1: Vector3 = make_vector3(amount); *temporary___g1; }));
}

init :: (using uv_mesh_decl: *Uv_Mesh_Decl) {
    vertex_uv_data = null;
    index_data = null;
    face_material_data = cast(*u32) null;
    vertex_count = 0;
    vertex_stride = 0;
    index_count = 0;
    index_offset = 0;
    index_format = INDEX_FORMAT_U_INT16;
}

init :: (using chart_options_: *Chart_Options) {
    param_func = cast(Parameterize_Func) null;

    max_chart_area = 0.0;
    max_boundary_length = 0.0;

    normal_deviation_weight = 2.0;
    roundness_weight = 0.01;
    straightness_weight = 6.0;
    normal_seam_weight = 4.0;
    texture_seam_weight = 0.5;

    max_cost = 2.0;
    max_iterations = 1;

    use_input_mesh_uvs = false;
    fix_winding = false;
}

init :: (using pack_options_: *Pack_Options) {
    max_chart_size = 0;

    padding = 0;

    texels_per_unit = 0.0;

    resolution = 0;

    bilinear = true;

    block_align = false;

    brute_force = false;

    create_image = false;

    rotate_charts_to_axis = true;

    rotate_charts = true;
}

init :: (using vector2: *Vector2) {
}

make_vector2 :: (f: float32) -> Vector2 {
    return Vector2.{x = f, y = f};
}

make_vector2 :: (x: float32, y: float32) -> Vector2 {
    return Vector2.{x = x, y = y};
}

subtract_2 :: (using vector2: *Vector2) -> Vector2 {
    return make_vector2(-x, -y);
}

multiply_assign_3 :: (using vector2: *Vector2, v: *Vector2) {
    x *= v.x;
    y *= v.y;
}

init :: (using vector2i: *Vector2i) {
}

make_vector2i :: (x: s32, y: s32) -> Vector2i {
    return Vector2i.{x = x, y = y};
}

init :: (using vector3: *Vector3) {
}

make_vector3 :: (f: float32) -> Vector3 {
    return Vector3.{x = f, y = f, z = f};
}

make_vector3 :: (x: float32, y: float32, z: float32) -> Vector3 {
    return Vector3.{x = x, y = y, z = z};
}

make_vector3 :: (v: *Vector2, z: float32) -> Vector3 {
    return Vector3.{x = v.x, y = v.y, z = z};
}

xy :: (using vector3: *Vector3) -> Vector2 {
    return make_vector2(x, y);
}

multiply_assign_4 :: (using vector3: *Vector3, v: *Vector3) {
    x *= v.x;
    y *= v.y;
    z *= v.z;
}

divide_assign_2 :: (using vector3: *Vector3, v: *Vector3) {
    x /= v.x;
    y /= v.y;
    z /= v.z;
}

init :: (using extents2: *Extents2) {
    init(*min);
    init(*max);
}

init :: (using extents2: *Extents2, p1: Vector2, p2: Vector2) {
    local_p1: Vector2 = p1;
    local_p2: Vector2 = p2;
    init(*min);
    init(*max);

    assign(*min, (ifx true { temporary___g0: Vector2 = internal_min(*local_p1, *local_p2); *temporary___g0; }));
    assign(*max, (ifx true { temporary___g1: Vector2 = internal_max(*local_p1, *local_p2); *temporary___g1; }));
}

midpoint :: (using extents2: *Extents2) -> Vector2 {
    return make_vector2(min.x + (max.x - min.x) * 0.5, min.y + (max.y - min.y) * 0.5);
}

init :: (using aabb: *AABB) {
    assignment_80: Vector3 =
        make_vector3(cast(float32) 3.40282347e+38, cast(float32) 3.40282347e+38, cast(float32) 3.40282347e+38);
    ((*min).*) = assignment_80;
    assignment_81: Vector3 =
        make_vector3(-cast(float32) 3.40282347e+38, -cast(float32) 3.40282347e+38, -cast(float32) 3.40282347e+38);
    ((*max).*) = assignment_81;
}

init :: (using aabb: *AABB, _min: *Vector3, _max: *Vector3) {
    min = _min.*;
    max = _max.*;
}

init :: (using aabb: *AABB, p: *Vector3, radius: float32) {
    min = p.*;
    max = p.*;
    if radius > 0.0 {
        expand(aabb, radius);
    }
}

init :: (using array_base: *Array_Base, _element_size: u32, mem_tag: s32) {
    buffer = cast(*u8) null;
    element_size = _element_size;
    size = 0;
    capacity = 0;
}

deinit :: (using array_base: *Array_Base) {
    internal_realloc(
        cast(*void) buffer,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        961
    );
}

remove_at_fast :: (using array_base: *Array_Base, index: u32) {
    assert(index >= 0 && index < size);
    assert(buffer != null);
    if buffer != null {
        if size > 1 && index != size - 1 {
            copy_memory(
                buffer + element_size * index,
                buffer + element_size * (size - 1),
                cast,no_check(u64) element_size
            );
        }
        if size > 0 {
            size -= 1;
        }
    }
}

init :: (using array: *Array(u32), mem_tag: s32) {
    init(*base, 4, mem_tag);
}

deinit :: (using array: *Array(u32)) {
    cpp_transpiler_subobject_cleanup_g126: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(u64), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(u64)) {
    cpp_transpiler_subobject_cleanup_g127: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(AABB), mem_tag: s32) {
    init(*base, 24, mem_tag);
}

deinit :: (using array: *Array(AABB)) {
    cpp_transpiler_subobject_cleanup_g128: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(BVH_Node), mem_tag: s32) {
    init(*base, 36, mem_tag);
}

deinit :: (using array: *Array(BVH_Node)) {
    cpp_transpiler_subobject_cleanup_g129: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Vector3), mem_tag: s32) {
    init(*base, 12, mem_tag);
}

deinit :: (using array: *Array(Vector3)) {
    cpp_transpiler_subobject_cleanup_g130: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(float32), mem_tag: s32) {
    init(*base, 4, mem_tag);
}

deinit :: (using array: *Array(float32)) {
    cpp_transpiler_subobject_cleanup_g131: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Vector2), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(Vector2)) {
    cpp_transpiler_subobject_cleanup_g132: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(bool), mem_tag: s32) {
    init(*base, 1, mem_tag);
}

deinit :: (using array: *Array(bool)) {
    cpp_transpiler_subobject_cleanup_g133: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Edge_Key), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(Edge_Key)) {
    cpp_transpiler_subobject_cleanup_g134: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Task), mem_tag: s32) {
    init(*base, 16, mem_tag);
}

deinit :: (using array: *Array(Task)) {
    cpp_transpiler_subobject_cleanup_g135: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Task_Scheduler_Task_Group), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Task_Scheduler_Task_Group)) {
    cpp_transpiler_subobject_cleanup_g136: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(s32), mem_tag: s32) {
    init(*base, 4, mem_tag);
}

deinit :: (using array: *Array(s32)) {
    cpp_transpiler_subobject_cleanup_g137: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Uv_Mesh_Chart), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Uv_Mesh_Chart)) {
    cpp_transpiler_subobject_cleanup_g138: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Cost_Queue_Pair), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(Cost_Queue_Pair)) {
    cpp_transpiler_subobject_cleanup_g139: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Original_Uv_Charts_Chart), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(Original_Uv_Charts_Chart)) {
    cpp_transpiler_subobject_cleanup_g140: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Basis), mem_tag: s32) {
    init(*base, 36, mem_tag);
}

deinit :: (using array: *Array(Basis)) {
    cpp_transpiler_subobject_cleanup_g141: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Planar_Charts_Chart), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(Planar_Charts_Chart)) {
    cpp_transpiler_subobject_cleanup_g142: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Clustered_Charts_Chart), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Clustered_Charts_Chart)) {
    cpp_transpiler_subobject_cleanup_g143: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Uv_Mesh), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Uv_Mesh)) {
    cpp_transpiler_subobject_cleanup_g144: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Compute_Uv_Mesh_Charts_Task_Args), mem_tag: s32) {
    init(*base, 16, mem_tag);
}

deinit :: (using array: *Array(Compute_Uv_Mesh_Charts_Task_Args)) {
    cpp_transpiler_subobject_cleanup_g145: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Piecewise_Param_Candidate), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Piecewise_Param_Candidate)) {
    cpp_transpiler_subobject_cleanup_g146: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Param_Chart), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Param_Chart)) {
    cpp_transpiler_subobject_cleanup_g147: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Create_And_Parameterize_Chart_Task_Args), mem_tag: s32) {
    init(*base, 80, mem_tag);
}

deinit :: (using array: *Array(Create_And_Parameterize_Chart_Task_Args)) {
    cpp_transpiler_subobject_cleanup_g148: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Chart_Group), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

init :: (using array: *Array(*Internal_Mesh), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Internal_Mesh)) {
    cpp_transpiler_subobject_cleanup_g149: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Invalid_Mesh_Geometry), mem_tag: s32) {
    init(*base, 72, mem_tag);
}

deinit :: (using array: *Array(Invalid_Mesh_Geometry)) {
    cpp_transpiler_subobject_cleanup_g150: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Array(*Chart_Group)), mem_tag: s32) {
    init(*base, 24, mem_tag);
}

deinit :: (using array: *Array(Array(*Chart_Group))) {
    cpp_transpiler_subobject_cleanup_g151: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Mesh_Compute_Charts_Task_Args), mem_tag: s32) {
    init(*base, 24, mem_tag);
}

deinit :: (using array: *Array(Mesh_Compute_Charts_Task_Args)) {
    cpp_transpiler_subobject_cleanup_g152: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Atlas_Image), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Atlas_Image)) {
    cpp_transpiler_subobject_cleanup_g153: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Bit_Image), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Bit_Image)) {
    cpp_transpiler_subobject_cleanup_g154: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Pack_Chart), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Pack_Chart)) {
    cpp_transpiler_subobject_cleanup_g155: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Add_Chart_Task_Args), mem_tag: s32) {
    init(*base, 16, mem_tag);
}

deinit :: (using array: *Array(Add_Chart_Task_Args)) {
    cpp_transpiler_subobject_cleanup_g156: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(Vector2i), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(Vector2i)) {
    cpp_transpiler_subobject_cleanup_g157: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(u8), mem_tag: s32) {
    init(*base, 1, mem_tag);
}

deinit :: (using array: *Array(u8)) {
    cpp_transpiler_subobject_cleanup_g158: bool = ---;
    defer deinit(*base);
}

init_2 :: (using array: *Array(*Internal_Mesh), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit_2 :: (using array: *Array(*Internal_Mesh)) {
    cpp_transpiler_subobject_cleanup_g159: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Mesh_Polygon_Mapping), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Mesh_Polygon_Mapping)) {
    cpp_transpiler_subobject_cleanup_g160: bool = ---;
    defer deinit(*base);
}

init :: (using array: *Array(*Uv_Mesh_Instance), mem_tag: s32) {
    init(*base, 8, mem_tag);
}

deinit :: (using array: *Array(*Uv_Mesh_Instance)) {
    cpp_transpiler_subobject_cleanup_g161: bool = ---;
    defer deinit(*base);
}

make_struct_xatlas_internal_array_view_class_xatlas_internal_vector2 :: (a: *Array(Vector2)) -> Array_View(Vector2) {
    return Array_View(Vector2).{data = cast,no_check(*Vector2) data_2(a), length = size(a)};
}

make_struct_xatlas_internal_array_view_struct_xatlas_internal_uv_mesh :: (a: *Array(*Uv_Mesh)) -> Array_View(*Uv_Mesh) {
    return Array_View(*Uv_Mesh).{data = cast,no_check(**Uv_Mesh) data(a), length = size(a)};
}

make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector3 :: (
    a: *Array(Vector3)
) -> Const_Array_View(Vector3) {
    return Const_Array_View(Vector3).{data = cast,no_check(*Vector3) data(a), length = size(a)};
}

make_struct_xatlas_internal_const_array_view_float :: (a: *Array(float32)) -> Const_Array_View(float32) {
    return Const_Array_View(float32).{data = cast,no_check(*float32) data(a), length = size(a)};
}

make_struct_xatlas_internal_const_array_view_unsigned_int :: (a: *Array(u32)) -> Const_Array_View(u32) {
    return Const_Array_View(u32).{data = cast,no_check(*u32) data_3(a), length = size(a)};
}

make_struct_xatlas_internal_const_array_view_unsigned_int :: (data_40: *u32, length: u32) -> Const_Array_View(u32) {
    return Const_Array_View(u32).{data = data_40, length = length};
}

make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2 :: (
    a: *Array(Vector2)
) -> Const_Array_View(Vector2) {
    return Const_Array_View(Vector2).{data = cast,no_check(*Vector2) data(a), length = size(a)};
}

make_struct_xatlas_internal_const_array_view_class_xatlas_internal_vector2 :: (
    av: Array_View(Vector2)
) -> Const_Array_View(Vector2) {
    return Const_Array_View(Vector2).{data = av.data, length = av.length};
}

init :: (using basis: *Basis) {
}

init :: (using bit_array: *Bit_Array) {
    size = 0;
    init(*word_array, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using bit_array: *Bit_Array, sz: u32) {
    init(*word_array, cast(s32) INTERNAL_MEM_TAG_DEFAULT);

    resize(bit_array, sz);
}

deinit :: (using bit_array: *Bit_Array) {
    cpp_transpiler_subobject_cleanup_g162: bool = ---;
    defer deinit(*word_array);
}

init :: (using bit_image: *Bit_Image) {
    width = 0;
    height = 0;
    row_stride = 0;
    init(*data, cast(s32) INTERNAL_MEM_TAG_BIT_IMAGE);
}

init :: (using bit_image: *Bit_Image, w: u32, h: u32) {
    width = w;
    height = h;
    init(*data, cast(s32) INTERNAL_MEM_TAG_BIT_IMAGE);

    row_stride = (width + 63) >> 6;
    resize(*data, row_stride * height);
    zero_out_memory(*data);
}

init :: (using bvh: *BVH, _object_aabbs: *Array(AABB), leaf_size: u32) {
    init(*object_ids, cast(s32) INTERNAL_MEM_TAG_BVH);
    init(*nodes, cast(s32) INTERNAL_MEM_TAG_BVH);

    object_aabbs = cast,no_check(*Array(AABB)) ((cast(**Array(AABB)) *(_object_aabbs)).*);
    if is_empty(object_aabbs) {
        return;
    }
    resize(*object_ids, size(_object_aabbs));
    {
        i_2: u32 = 0;
        while i_2 < size(*object_ids) {
            assignment_82: u32 = i_2;
            (((cast(**u32) *(index_explicit(*object_ids, i_2))).*).*) = assignment_82;
            i_2 += 1;
        }
    }
    todo: [128] BVH_Build_Entry = ---;
    stackptr: u32 = 0;
    K_ROOT: u32 = 0xfffffffc;
    K_UNTOUCHED: u32 = 0xffffffff;
    K_TOUCHED_TWICE: u32 = 0xfffffffd;

    todo[stackptr].start = 0;
    todo[stackptr].end = size(_object_aabbs);
    todo[stackptr].parent = K_ROOT;
    stackptr += 1;
    node: BVH_Node = ---;
    init(*node);
    reserve(*nodes, size(_object_aabbs) * 2);
    n_nodes: u32 = 0;
    while stackptr > 0 {
        bnode := todo.data + c_transpiler_pre_decrement(*(stackptr));
        START := bnode.start;
        END := bnode.end;
        N_PRIMS := END - START;
        n_nodes += 1;
        node.start = START;
        node.n_prims = N_PRIMS;
        node.right_offset = K_UNTOUCHED;

        bb: AABB =
            ((cast(**AABB) *(index_explicit_15(_object_aabbs, ((cast(**u32) *(index_explicit(*object_ids, START))).*).*))).*).*;
        bc: AABB = ---;
        init(
            *bc,
            (ifx true { temporary___g0: Vector3 = centroid(index_explicit_15(_object_aabbs, ((cast(**u32) *(index_explicit(*object_ids, START))).*).*)); *temporary___g0; }),
            0.0
        );
        {
            p := START + 1;
            while p < END {
                expand_to_include(
                    *bb,
                    index_explicit_15(_object_aabbs, ((cast(**u32) *(index_explicit(*object_ids, p))).*).*)
                );
                expand_to_include(
                    *bc,
                    (ifx true { temporary___g1: Vector3 = centroid(index_explicit_15(_object_aabbs, ((cast(**u32) *(index_explicit(*object_ids, p))).*).*)); *temporary___g1; })
                );
                p += 1;
            }
        }
        node.aabb = bb;

        if N_PRIMS <= leaf_size {
            node.right_offset = 0;
        }
        push_back(*nodes, *node);

        if bnode.parent != K_ROOT {
            (index_explicit_60(*nodes, bnode.parent)).right_offset -= 1;

            if (index_explicit_60(*nodes, bnode.parent)).right_offset == K_TOUCHED_TWICE {
                assignment_83: u32 = ((n_nodes - 1) - bnode.parent);
                ((index_explicit_60(*nodes, bnode.parent)).right_offset) = assignment_83;
            }
        }

        if node.right_offset == 0 {
            continue;
        }

        SPLIT_DIM := max_dimension(*bc);

        SPLIT_COORD := 0.5 * ((*bc.min.x)[SPLIT_DIM] + (*bc.max.x)[SPLIT_DIM]);

        mid := START;
        {
            i := START;
            while i < END {
                CENTROID :=
                    centroid(
                        index_explicit_15(
                        _object_aabbs,
                        ((cast(**u32) *(index_explicit(*object_ids, i))).*).*
                    )
                    );
                if (*CENTROID.x)[SPLIT_DIM] < SPLIT_COORD {
                    internal_swap(index_explicit(*object_ids, i), index_explicit(*object_ids, mid));
                    mid += 1;
                }
                i += 1;
            }
        }

        if mid == START || mid == END {
            mid = START + (END - START) / 2;
        }

        todo[stackptr].start = mid;
        todo[stackptr].end = END;
        todo[stackptr].parent = n_nodes - 1;
        stackptr += 1;

        todo[stackptr].start = START;
        todo[stackptr].end = mid;
        todo[stackptr].parent = n_nodes - 1;
        stackptr += 1;
    }
}

internal_swap :: (a: *u32, b: *u32) {
    temp := a.*;
    assignment_84: u32 = b.*;
    (((cast(**u32) *(a)).*).*) = assignment_84;
    assignment_85: u32 = temp;
    (((cast(**u32) *(b)).*).*) = assignment_85;
}

init :: (using node: *BVH_Node) {
    init(*aabb);
}

deinit :: (using bvh: *BVH) {
    cpp_transpiler_subobject_cleanup_g163: bool = ---;
    defer deinit(*object_ids);
    cpp_transpiler_subobject_cleanup_g164: bool = ---;
    defer deinit(*nodes);
}

init :: (using hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key)), _mem_tag: s32, _size: u32) {
    mem_tag = _mem_tag;
    size = _size;
    num_slots = 0;
    slots = cast(*u32) null;
    init(*keys, _mem_tag);
    init(*next, _mem_tag);
}

deinit :: (using hash_map: *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key))) {
    cpp_transpiler_subobject_cleanup_g165: bool = ---;
    defer deinit(*keys);
    cpp_transpiler_subobject_cleanup_g166: bool = ---;
    defer deinit(*next);
    if slots != null {
        internal_realloc(
            cast(*void) slots,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1951
        );
    }
}

init :: (using hash_map: *Hash_Map(Vector3, Hash(Vector3), Equal(Vector3)), _mem_tag: s32, _size: u32) {
    mem_tag = _mem_tag;
    size = _size;
    num_slots = 0;
    slots = cast(*u32) null;
    init(*keys, _mem_tag);
    init(*next, _mem_tag);
}

deinit :: (using hash_map: *Hash_Map(Vector3, Hash(Vector3), Equal(Vector3))) {
    cpp_transpiler_subobject_cleanup_g167: bool = ---;
    defer deinit(*keys);
    cpp_transpiler_subobject_cleanup_g168: bool = ---;
    defer deinit(*next);
    if slots != null {
        internal_realloc(
            cast(*void) slots,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1951
        );
    }
}

init :: (using hash_map: *Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)), _mem_tag: s32, _size: u32) {
    mem_tag = _mem_tag;
    size = _size;
    num_slots = 0;
    slots = cast(*u32) null;
    init(*keys, _mem_tag);
    init(*next, _mem_tag);
}

deinit :: (using hash_map: *Hash_Map(u32, Passthrough_Hash(u32), Equal(u32))) {
    cpp_transpiler_subobject_cleanup_g169: bool = ---;
    defer deinit(*keys);
    cpp_transpiler_subobject_cleanup_g170: bool = ---;
    defer deinit(*next);
    if slots != null {
        internal_realloc(
            cast(*void) slots,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1951
        );
    }
}

init :: (using hash_map: *Hash_Map(Vector2, Hash(Vector2), Equal(Vector2)), _mem_tag: s32, _size: u32) {
    mem_tag = _mem_tag;
    size = _size;
    num_slots = 0;
    slots = cast(*u32) null;
    init(*keys, _mem_tag);
    init(*next, _mem_tag);
}

deinit :: (using hash_map: *Hash_Map(Vector2, Hash(Vector2), Equal(Vector2))) {
    cpp_transpiler_subobject_cleanup_g171: bool = ---;
    defer deinit(*keys);
    cpp_transpiler_subobject_cleanup_g172: bool = ---;
    defer deinit(*next);
    if slots != null {
        internal_realloc(
            cast(*void) slots,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            1951
        );
    }
}

init :: (using kiss_rng: *KISS_Rng) {
    reset(kiss_rng);
}

init :: (using radix_sort_2: *Radix_Sort) {
    init(*buffer1, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*buffer2, cast(s32) INTERNAL_MEM_TAG_DEFAULT);

    valid_ranks = false;
}

deinit :: (using radix_sort_2: *Radix_Sort) {
    cpp_transpiler_subobject_cleanup_g173: bool = ---;
    defer deinit(*buffer1);
    cpp_transpiler_subobject_cleanup_g174: bool = ---;
    defer deinit(*buffer2);
}

init :: (using bounding_box2_d: *Bounding_Box2_D) {
    init(*major_axis);
    init(*minor_axis);
    init(*min_corner);
    init(*max_corner);
    init(*boundary_vertices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*coords, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*top, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*bottom, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*hull, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*radix);
}

init :: (using edge_key: *Edge_Key, k: *Edge_Key) {
    v0 = k.v0;
    v1 = k.v1;
}

make_edge_key :: (v0: u32, v1: u32) -> Edge_Key {
    return Edge_Key.{v0 = v0, v1 = v1};
}

init :: (
    using mesh: *Internal_Mesh,
    _epsilon: float32,
    approx_vertex_count: u32,
    approx_face_count: u32,
    _flags: u32,
    _id: u32
) {
    epsilon = _epsilon;
    flags = _flags;
    id = _id;
    init(*face_ignore, cast(s32) INTERNAL_MEM_TAG_MESH);
    init(*face_materials, cast(s32) INTERNAL_MEM_TAG_MESH);
    init(*indices, cast(s32) INTERNAL_MEM_TAG_MESH_INDICES);
    init(*positions, cast(s32) INTERNAL_MEM_TAG_MESH_POSITIONS);
    init(*normals, cast(s32) INTERNAL_MEM_TAG_MESH_NORMALS);
    init(*texcoords, cast(s32) INTERNAL_MEM_TAG_MESH_TEXCOORDS);
    init(*next_colocal_vertex, cast(s32) INTERNAL_MEM_TAG_MESH_COLOCALS);
    init(*first_colocal_vertex, cast(s32) INTERNAL_MEM_TAG_MESH_COLOCALS);
    init(*is_boundary_vertex);
    init(*boundary_edges, cast(s32) INTERNAL_MEM_TAG_MESH_BOUNDARIES);
    init(*opposite_edges, cast(s32) INTERNAL_MEM_TAG_MESH_BOUNDARIES);
    init(*edge_map, cast(s32) INTERNAL_MEM_TAG_MESH_EDGE_MAP, approx_face_count * 3);

    reserve(*indices, approx_face_count * 3);
    reserve(*positions, approx_vertex_count);
    reserve(*texcoords, approx_vertex_count);
    if flags & INTERNAL_MESH_FLAGS_HAS_IGNORED_FACES != 0 {
        reserve(*face_ignore, approx_face_count);
    }
    if flags & INTERNAL_MESH_FLAGS_HAS_NORMALS != 0 {
        reserve(*normals, approx_vertex_count);
    }
    if flags & INTERNAL_MESH_FLAGS_HAS_MATERIALS != 0 {
        reserve(*face_materials, approx_face_count);
    }
}

id :: (using mesh: *Internal_Mesh) -> u32 {
    return id;
}

compute_face_centroid :: (using mesh: *Internal_Mesh, face_2: u32) -> Vector3 {
    sum: Vector3 = make_vector3(0.0);
    for i: 0..cast(u32) 3 - 1 {
        add_assign(
            *sum,
            index_explicit_9(*positions, ((cast(**u32) *(index_explicit_7(*indices, (face_2 * 3) + i))).*).*)
        );
    }
    return internal_operator_in_xatlas(*sum, 3.0);
}

is_boundary_edge :: (using mesh: *Internal_Mesh, edge_2: u32) -> bool {
    return ((cast(**u32) *(index_explicit_7(*opposite_edges, edge_2))).*).* == 4294967295;
}

edge_map :: (using mesh: *Internal_Mesh) -> *Hash_Map(Edge_Key, Edge_Hash, Equal(Edge_Key)) {
    return *edge_map;
}

init :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator, _mesh: *Internal_Mesh, _face: u32) {
    mesh = _mesh;
    face = _face;
    relative_edge = 0;

    edge = face * 3;
}

relative_edge :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> u32 {
    return relative_edge;
}

face :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> u32 {
    return face;
}

position0 :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> *Vector3 {
    return index_explicit_9(*mesh.positions, vertex0(face_edge_iterator));
}

position1 :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> *Vector3 {
    return index_explicit_9(*mesh.positions, vertex1(face_edge_iterator));
}

normal0 :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> *Vector3 {
    return index_explicit_9(*mesh.normals, vertex0(face_edge_iterator));
}

normal1 :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> *Vector3 {
    return index_explicit_9(*mesh.normals, vertex1(face_edge_iterator));
}

texcoord0 :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> *Vector2 {
    return index_explicit_18(*mesh.texcoords, vertex0(face_edge_iterator));
}

texcoord1 :: (using face_edge_iterator: *Mesh_Face_Edge_Iterator) -> *Vector2 {
    return index_explicit_18(*mesh.texcoords, vertex1(face_edge_iterator));
}

init :: (using mesh_face_groups: *Mesh_Face_Groups, _mesh: *Internal_Mesh) {
    mesh = _mesh;
    init(*groups, cast(s32) INTERNAL_MEM_TAG_MESH);
    init(*first_face, cast(s32) INTERNAL_MEM_TAG_MESH);
    init(*next_face, cast(s32) INTERNAL_MEM_TAG_MESH);
    init(*face_count, cast(s32) INTERNAL_MEM_TAG_MESH);
}

next_face :: (using mesh_face_groups: *Mesh_Face_Groups, face_2: u32) -> u32 {
    return ((cast(**u32) *(index_explicit_7(*next_face, face_2))).*).*;
}

init :: (
    using iterator: *Mesh_Face_Groups_Iterator,
    _mesh_face_groups: *Mesh_Face_Groups,
    group: Mesh_Face_Groups_Handle
) {
    mesh_face_groups = _mesh_face_groups;

    assert(group != cast(u32) 4294967295);
    current = ((cast(**u32) *(index_explicit_7(*mesh_face_groups.first_face, group))).*).*;
}

init :: (using invalid_mesh_geometry_2: *Invalid_Mesh_Geometry) {
    init(*faces, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*indices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*vertex_to_source_vertex_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (
    using progress: *Progress,
    _category: Progress_Category,
    _func: Progress_Func,
    _user_data: *void,
    _max_value: u32
) {
    init(*cancel, false);
    category = _category;
    func = _func;
    user_data = _user_data;
    init(*value, 0);
    init(*max_value, _max_value);
    init(*percent, 0);

    if func != null {
        if !func(_category, 0, _user_data) {
            assign_in_xatlas(*cancel, true);
        }
    }
}

init :: (using struct_atomic_bool: *struct_atomic_Bool, i: bool) {
    assignment_86: struct_atomic_base_Bool = make_struct_std_atomic_base_bool(i);
    ((*base).*) = assignment_86;
}

make_struct_std_atomic_base_bool :: (i: std_atomic_base_bool_int_type) -> struct_atomic_base_Bool {
    return struct_atomic_base_Bool.{i = i};
}

init :: (using struct_atomic_unsigned_int_: *struct_atomic_unsigned_int, i: std_atomic_unsigned_int_integral_type) {
    assignment_87: struct_atomic_base_unsigned_int = make_struct_std_atomic_base_unsigned_int(i);
    ((cast(*struct_atomic_base_unsigned_int) struct_atomic_unsigned_int_).*) = assignment_87;
}

make_struct_std_atomic_base_unsigned_int :: (
    i: std_atomic_base_unsigned_int_int_type
) -> struct_atomic_base_unsigned_int {
    return struct_atomic_base_unsigned_int.{i = i};
}

lock :: (using spinlock: *Spinlock) {
    while test_and_set(*lock, STD_MEMORY_ORDER_ACQUIRE) {
    }
}

unlock :: (using spinlock: *Spinlock) {
    clear(*lock, STD_MEMORY_ORDER_RELEASE);
}

init :: (using task_group_handle: *Task_Group_Handle) {
    value = 4294967295;
}

thread_count :: (using task_scheduler: *Task_Scheduler) -> u32 {
    return 1;
}

init :: (using task_group: *Task_Scheduler_Task_Group) {
    init(*queue, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using task_scheduler: *Task_Scheduler) {
    init(*groups, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using thread_local: *Thread_Local(Uniform_Grid2)) {
    N: u32 = 1;

    array =
        cast(*Uniform_Grid2) internal_realloc(
            null,
            176 * cast(u64) N,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            3431
        );
    if 0 < N {
        for i: 0..N - 1 {
            (ifx true {
    cpp_transpiler_new_g175 := cast(*Uniform_Grid2) cast(*void) *array[i];
    init(cpp_transpiler_new_g175);
    cpp_transpiler_new_g175;
})
;
        }
    }
}

deinit :: (using thread_local: *Thread_Local(Uniform_Grid2)) {
    N: u32 = 1;

    if 0 < N {
        for i: 0..N - 1 {
            deinit(*array[i]);
        }
    }
    internal_realloc(
        cast(*void) array,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        3445
    );
}

init :: (using thread_local: *Thread_Local(Chart_Ctor_Buffers)) {
    N: u32 = 1;

    array =
        cast(*Chart_Ctor_Buffers) internal_realloc(
            null,
            48 * cast(u64) N,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            3431
        );
    if 0 < N {
        for i: 0..N - 1 {
            (ifx true {
    cpp_transpiler_new_g176 := cast(*Chart_Ctor_Buffers) cast(*void) *array[i];
    init(cpp_transpiler_new_g176);
    cpp_transpiler_new_g176;
})
;
        }
    }
}

deinit :: (using thread_local: *Thread_Local(Chart_Ctor_Buffers)) {
    N: u32 = 1;

    if 0 < N {
        for i: 0..N - 1 {
            deinit(*array[i]);
        }
    }
    internal_realloc(
        cast(*void) array,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        3445
    );
}

init :: (using thread_local: *Thread_Local(Piecewise_Param)) {
    N: u32 = 1;

    array =
        cast(*Piecewise_Param) internal_realloc(
            null,
            456 * cast(u64) N,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            3431
        );
    if 0 < N {
        for i: 0..N - 1 {
            (ifx true {
    cpp_transpiler_new_g177 := cast(*Piecewise_Param) cast(*void) *array[i];
    init(cpp_transpiler_new_g177);
    cpp_transpiler_new_g177;
})
;
        }
    }
}

deinit :: (using thread_local: *Thread_Local(Piecewise_Param)) {
    N: u32 = 1;

    if 0 < N {
        for i: 0..N - 1 {
            deinit(*array[i]);
        }
    }
    internal_realloc(
        cast(*void) array,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        3445
    );
}

init :: (using thread_local: *Thread_Local(Segment_Atlas)) {
    N: u32 = 1;

    array =
        cast(*Segment_Atlas) internal_realloc(
            null,
            896 * cast(u64) N,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            3431
        );
    if 0 < N {
        for i: 0..N - 1 {
            (ifx true {
    cpp_transpiler_new_g178 := cast(*Segment_Atlas) cast(*void) *array[i];
    init(cpp_transpiler_new_g178);
    cpp_transpiler_new_g178;
})
;
        }
    }
}

deinit :: (using thread_local: *Thread_Local(Segment_Atlas)) {
    N: u32 = 1;

    if 0 < N {
        for i: 0..N - 1 {
            deinit(*array[i]);
        }
    }
    internal_realloc(
        cast(*void) array,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        3445
    );
}

init :: (using thread_local: *Thread_Local(Bounding_Box2_D)) {
    N: u32 = 1;

    array =
        cast(*Bounding_Box2_D) internal_realloc(
            null,
            224 * cast(u64) N,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            3431
        );
    if 0 < N {
        for i: 0..N - 1 {
            (ifx true {
    cpp_transpiler_new_g179 := cast(*Bounding_Box2_D) cast(*void) *array[i];
    init(cpp_transpiler_new_g179);
    cpp_transpiler_new_g179;
})
;
        }
    }
}

deinit :: (using thread_local: *Thread_Local(Bounding_Box2_D)) {
    N: u32 = 1;

    if 0 < N {
        for i: 0..N - 1 {
            deinit(*array[i]);
        }
    }
    internal_realloc(
        cast(*void) array,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        3445
    );
}

init :: (using triangulator: *Triangulator) {
    init(*polygon_vertices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*polygon_angles, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*polygon_points, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

deinit :: (using triangulator: *Triangulator) {
    cpp_transpiler_subobject_cleanup_g180: bool = ---;
    defer deinit(*polygon_vertices);
    cpp_transpiler_subobject_cleanup_g181: bool = ---;
    defer deinit(*polygon_angles);
    cpp_transpiler_subobject_cleanup_g182: bool = ---;
    defer deinit(*polygon_points);
}

init :: (using uniform_grid2: *Uniform_Grid2) {
    init(*edges, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    assignment_88: Const_Array_View(Vector2) = Const_Array_View(Vector2).{};
    ((*positions).*) = assignment_88;
    assignment_89: Const_Array_View(u32) = Const_Array_View(u32).{};
    ((*indices).*) = assignment_89;
    init(*grid_origin);
    init(*cell_data_offsets, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*cell_data, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*potential_edges, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*traversed_cell_offsets, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using uv_mesh_chart: *Uv_Mesh_Chart) {
    init(*faces, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*indices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using uv_mesh: *Uv_Mesh) {
    init(*decl);
    init(*face_ignore);
    init(*face_materials, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*indices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*texcoords, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*charts, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*vertex_to_chart_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using uv_mesh_instance: *Uv_Mesh_Instance) {
    init(*texcoords, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using clipped_triangle: *Clipped_Triangle, a: *Vector2, b: *Vector2, c_: *Vector2) {
    {
        cpp_transpiler_member_array_index_g183: u64 = 0;
        while cpp_transpiler_member_array_index_g183 < 8 {
            init(*vertices_a[cpp_transpiler_member_array_index_g183]);
            cpp_transpiler_member_array_index_g183 += 1;
        }
    }
    {
        cpp_transpiler_member_array_index_g184: u64 = 0;
        while cpp_transpiler_member_array_index_g184 < 8 {
            init(*vertices_b[cpp_transpiler_member_array_index_g184]);
            cpp_transpiler_member_array_index_g184 += 1;
        }
    }

    num_vertices = 3;
    active_vertex_buffer = 0;
    assign_3(vertices_a.data + 0, a);
    assign_3(vertices_a.data + 1, b);
    assign_3(vertices_a.data + 2, c_);
    vertex_buffers[0] = vertices_a.data;
    vertex_buffers[1] = vertices_b.data;
    area = 0;
}

init :: (using triangle: *Triangle, v0: *Vector2, _v1: *Vector2, _v2: *Vector2) {
    v1 = v0.*;
    v2 = _v2.*;
    v3 = _v1.*;
    assignment_90: Vector2 = make_vector2(0.0);
    ((*n1).*) = assignment_90;
    assignment_91: Vector2 = make_vector2(0.0);
    ((*n2).*) = assignment_91;
    assignment_92: Vector2 = make_vector2(0.0);
    ((*n3).*) = assignment_92;

    flip_backface(triangle);

    if is_valid(triangle) {
        compute_unit_inward_normals(triangle);
    }
}

init :: (using cost_queue: *Cost_Queue, size_3: u32) {
    max_size = size_3;
    init(*pairs, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_CHART_CANDIDATES);
}

deinit :: (using cost_queue: *Cost_Queue) {
    cpp_transpiler_subobject_cleanup_g185: bool = ---;
    defer deinit(*pairs);
}

init :: (using atlas_data: *Atlas_Data) {
    init(*options);
    mesh = cast(*Internal_Mesh) null;

    init(*edge_dihedral_angles, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_MESH_DATA);
    init(*edge_lengths, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_MESH_DATA);
    init(*face_areas, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_MESH_DATA);
    init(*face_uv_areas, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*face_normals, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_MESH_DATA);
    init(*is_face_in_chart);
}

deinit :: (using atlas_data: *Atlas_Data) {
    cpp_transpiler_subobject_cleanup_g186: bool = ---;
    defer deinit(*edge_dihedral_angles);
    cpp_transpiler_subobject_cleanup_g187: bool = ---;
    defer deinit(*edge_lengths);
    cpp_transpiler_subobject_cleanup_g188: bool = ---;
    defer deinit(*face_areas);
    cpp_transpiler_subobject_cleanup_g189: bool = ---;
    defer deinit(*face_uv_areas);
    cpp_transpiler_subobject_cleanup_g190: bool = ---;
    defer deinit(*face_normals);
    cpp_transpiler_subobject_cleanup_g191: bool = ---;
    defer deinit(*is_face_in_chart);
}

init :: (using original_uv_charts: *Original_Uv_Charts, _data: *Atlas_Data) {
    data = cast,no_check(*Atlas_Data) _data;
    init(*charts, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart_basis, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart_faces, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*temp_points, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

deinit :: (using original_uv_charts: *Original_Uv_Charts) {
    cpp_transpiler_subobject_cleanup_g192: bool = ---;
    defer deinit(*charts);
    cpp_transpiler_subobject_cleanup_g193: bool = ---;
    defer deinit(*chart_basis);
    cpp_transpiler_subobject_cleanup_g194: bool = ---;
    defer deinit(*chart_faces);
    cpp_transpiler_subobject_cleanup_g195: bool = ---;
    defer deinit(*temp_points);
}

init :: (using planar_charts: *Planar_Charts, _data: *Atlas_Data) {
    data = cast,no_check(*Atlas_Data) _data;
    init(*region_first_face, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*next_region_face, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_PLANAR_REGIONS);
    init(*face_to_region_id, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_PLANAR_REGIONS);
    init(*region_areas, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*charts, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart_faces, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart_basis, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

deinit :: (using planar_charts: *Planar_Charts) {
    cpp_transpiler_subobject_cleanup_g196: bool = ---;
    defer deinit(*region_first_face);
    cpp_transpiler_subobject_cleanup_g197: bool = ---;
    defer deinit(*next_region_face);
    cpp_transpiler_subobject_cleanup_g198: bool = ---;
    defer deinit(*face_to_region_id);
    cpp_transpiler_subobject_cleanup_g199: bool = ---;
    defer deinit(*region_areas);
    cpp_transpiler_subobject_cleanup_g200: bool = ---;
    defer deinit(*charts);
    cpp_transpiler_subobject_cleanup_g201: bool = ---;
    defer deinit(*chart_faces);
    cpp_transpiler_subobject_cleanup_g202: bool = ---;
    defer deinit(*chart_basis);
}

init :: (using clustered_charts: *Clustered_Charts, _data: *Atlas_Data, _planar_charts: *Planar_Charts) {
    data = cast,no_check(*Atlas_Data) _data;
    planar_charts = cast,no_check(*Planar_Charts) _planar_charts;
    init(*texcoords, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_MESH_DATA);
    init(*face_charts, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*charts, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*best_triangles, 10);
    init(*temp_points, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*boundary_grid);
    init(*shared_boundary_lengths, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*shared_boundary_lengths_no_seams, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*shared_boundary_edge_count_no_seams, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    placing_seeds = false;
}

deinit :: (using clustered_charts: *Clustered_Charts) {
    cpp_transpiler_subobject_cleanup_g203: bool = ---;
    defer deinit(*texcoords);
    cpp_transpiler_subobject_cleanup_g204: bool = ---;
    defer deinit(*face_charts);
    cpp_transpiler_subobject_cleanup_g205: bool = ---;
    defer deinit(*charts);
    cpp_transpiler_subobject_cleanup_g206: bool = ---;
    defer deinit(*best_triangles);
    cpp_transpiler_subobject_cleanup_g207: bool = ---;
    defer deinit(*temp_points);
    cpp_transpiler_subobject_cleanup_g208: bool = ---;
    defer deinit(*boundary_grid);
    cpp_transpiler_subobject_cleanup_g209: bool = ---;
    defer deinit(*shared_boundary_lengths);
    cpp_transpiler_subobject_cleanup_g210: bool = ---;
    defer deinit(*shared_boundary_lengths_no_seams);
    cpp_transpiler_subobject_cleanup_g211: bool = ---;
    defer deinit(*shared_boundary_edge_count_no_seams);
    {
        CHART_COUNT := size(*charts);
        if 0 < CHART_COUNT {
            for i: 0..CHART_COUNT - 1 {
                deinit((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, i)).*);
                internal_realloc(
                    cast(*void) ((cast(**Clustered_Charts_Chart) index_explicit_11(*charts, i)).*),
                    0,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    5327
                );
            }
        }
    }
}

init :: (using chart: *Clustered_Charts_Chart) {
    id = -1;
    init(*basis);

    area = 0.0;
    boundary_length = 0.0;
    init(*faces, cast(s32) INTERNAL_MEM_TAG_SEGMENT_ATLAS_CHART_FACES);
    init(*failed_planar_regions, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*candidates, 4294967295);
}

init :: (using atlas: *Segment_Atlas) {
    init(*data);
    init(*original_uv_charts, *data);
    init(*planar_charts, *data);
    init(*clustered_charts, *data, *planar_charts);
}

init :: (using compute_uv_mesh_charts_task: *Compute_Uv_Mesh_Charts_Task, args: *Compute_Uv_Mesh_Charts_Task_Args) {
    mesh = args.mesh;
    progress = args.progress;
    init(*uv_to_edge_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT, size(*mesh.indices));
    init(*face_assigned, size(*mesh.indices) / 3);
}

deinit :: (using compute_uv_mesh_charts_task: *Compute_Uv_Mesh_Charts_Task) {
    cpp_transpiler_subobject_cleanup_g212: bool = ---;
    defer deinit(*uv_to_edge_map);
    cpp_transpiler_subobject_cleanup_g213: bool = ---;
    defer deinit(*face_assigned);
}

init :: (using candidate_iterator: *Piecewise_Param_Candidate_Iterator, head: *Piecewise_Param_Candidate) {
    current = head;
    assert(head.prev == null);
}

parametric_area :: (using piecewise_param: *Piecewise_Param, _texcoords: *Vector2) -> float32 {
    v1 := *_texcoords[0];
    v2 := *_texcoords[1];
    v3 := *_texcoords[2];
    return ((v2.x - v1.x) * (v3.y - v1.y) - (v3.x - v1.x) * (v2.y - v1.y)) * 0.5;
}

init :: (using piecewise_param: *Piecewise_Param) {
    init(*texcoords, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*face_in_any_patch);
    init(*candidates, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*face_to_candidate, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*patch, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*face_in_patch);
    init(*vertex_in_patch);
    init(*face_invalid);
    init(*boundary_grid);
    init(*new_boundary_edges, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*ignore_boundary_edges, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using quality_2: *Quality) {
    boundary_intersection = false;

    total_triangle_count = 0;
    flipped_triangle_count = 0;
    zero_area_triangle_count = 0;

    total_parametric_area = 0.0;
    total_geometric_area = 0.0;
    stretch_metric = 0.0;
    max_stretch_metric = 0.0;
    conformal_metric = 0.0;
    authalic_metric = 0.0;
}

init :: (using chart_ctor_buffers: *Chart_Ctor_Buffers) {
    init(*chart_mesh_indices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*unified_mesh_indices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (
    using chart: *Param_Chart,
    _basis: *Basis,
    _generator_type: Chart_Generator_Type_Enum,
    faces_2: Const_Array_View(u32),
    source_mesh: *Internal_Mesh,
    chart_group_id: u32,
    chart_id: u32
) {
    local_faces_2: Const_Array_View(u32) = faces_2;
    basis = _basis.*;
    unified_mesh = cast(*Internal_Mesh) null;
    type = CHART_TYPE_LSCM;
    generator_type = _generator_type;
    tjunction_count = 0;
    original_vertex_count = 0;
    init(*original_indices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*face_to_source_face_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*vertex_to_source_vertex_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart_vertex_to_unified_vertex_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*backup_texcoords, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*quality);
    is_invalid = false;

    copy_from(*face_to_source_face_map, local_faces_2.data, local_faces_2.length);
    APPROX_VERTEX_COUNT: u32 =
        internal_min(
            (ifx true { temporary___g0: u32 = (local_faces_2.length * 3); *temporary___g0; }),
            (ifx true { temporary___g1: u32 = vertex_count(source_mesh); *temporary___g1; })
        );
    unified_mesh =
        (ifx true {
        cpp_transpiler_new_g214 :=
            cast(*Internal_Mesh) (cast(*void) (cast(*Internal_Mesh) internal_realloc(
                null,
                360,
                cast(s32) INTERNAL_MEM_TAG_MESH,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                7143
            )));
        init(
            cpp_transpiler_new_g214,
            epsilon(source_mesh),
            APPROX_VERTEX_COUNT,
            local_faces_2.length,
            0,
            4294967295
        );
        cpp_transpiler_new_g214;
    })
;
    source_vertex_to_unified_vertex_map: Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)) = ---;
    defer deinit(*source_vertex_to_unified_vertex_map);
    init(*source_vertex_to_unified_vertex_map, cast(s32) INTERNAL_MEM_TAG_MESH, APPROX_VERTEX_COUNT);
    source_vertex_to_chart_vertex_map: Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)) = ---;
    defer deinit(*source_vertex_to_chart_vertex_map);
    init(*source_vertex_to_chart_vertex_map, cast(s32) INTERNAL_MEM_TAG_MESH, APPROX_VERTEX_COUNT);
    resize(*original_indices, local_faces_2.length * 3);

    FACE_COUNT := local_faces_2.length;
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            unified_indices: [3] u32 = ---;
            for i: 0..cast(u32) 3 - 1 {
                SOURCE_VERTEX :=
                    vertex_at(
                        source_mesh,
                        (((cast(**u32) *(index_explicit(*face_to_source_face_map, f))).*).* * 3) + i
                    );
                source_unified_vertex := first_colocal_vertex(source_mesh, SOURCE_VERTEX);
                if cast,no_check(s32) generator_type == cast(s32) INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_ORIGINAL_UV &&
                    SOURCE_VERTEX != source_unified_vertex {
                    if !internal_equal(
                        texcoord_2(source_mesh, SOURCE_VERTEX),
                        texcoord_2(source_mesh, source_unified_vertex),
                        epsilon(source_mesh)
                    ) {
                        source_unified_vertex = SOURCE_VERTEX;
                    }
                }
                unified_vertex := get(*source_vertex_to_unified_vertex_map, *source_unified_vertex);
                if unified_vertex == 4294967295 {
                    unified_vertex = add(*source_vertex_to_unified_vertex_map, *source_unified_vertex);
                    add_vertex(
                        unified_mesh,
                        position(source_mesh, SOURCE_VERTEX),
                        (ifx true { temporary___g2: Vector3 = make_vector3(0.0); *temporary___g2; }),
                        texcoord_2(source_mesh, SOURCE_VERTEX)
                    );
                }
                if get(*source_vertex_to_chart_vertex_map, *SOURCE_VERTEX) == 4294967295 {
                    add(*source_vertex_to_chart_vertex_map, *SOURCE_VERTEX);
                    push_back(*vertex_to_source_vertex_map, *SOURCE_VERTEX);
                    push_back(*chart_vertex_to_unified_vertex_map, *unified_vertex);
                    original_vertex_count += 1;
                }
                assignment_93: u32 = get(*source_vertex_to_chart_vertex_map, *SOURCE_VERTEX);
                (((cast(**u32) *(index_explicit(*original_indices, (f * 3) + i))).*).*) = assignment_93;
                assert(((cast(**u32) *(index_explicit(*original_indices, (f * 3) + i))).*).* != 4294967295);
                unified_indices[i] = get(*source_vertex_to_unified_vertex_map, *source_unified_vertex);
                assert(unified_indices[i] != 4294967295);
            }
            add_face(unified_mesh, unified_indices.data, false, 4294967295);
        }
    }
    create_boundaries(unified_mesh);
    if cast,no_check(s32) generator_type == cast(s32) INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_PLANAR {
        type = CHART_TYPE_PLANAR;
        return;
    }
}

init :: (
    chart: *Param_Chart,
    buffers: *Chart_Ctor_Buffers,
    parent: *Param_Chart,
    parent_mesh: *Internal_Mesh,
    faces_2: Const_Array_View(u32),
    texcoords_3: Const_Array_View(Vector2),
    source_mesh: *Internal_Mesh
) {
    local_faces_2: Const_Array_View(u32) = faces_2;
    local_texcoords_3: Const_Array_View(Vector2) = texcoords_3;
    init(*chart.basis);
    chart.unified_mesh = cast(*Internal_Mesh) null;
    chart.type = CHART_TYPE_PIECEWISE;
    chart.generator_type = INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_PIECEWISE;
    chart.tjunction_count = 0;
    chart.original_vertex_count = 0;
    init(*chart.original_indices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart.face_to_source_face_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart.vertex_to_source_vertex_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart.chart_vertex_to_unified_vertex_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart.backup_texcoords, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*chart.quality);
    chart.is_invalid = false;

    FACE_COUNT := local_faces_2.length;
    resize(*chart.face_to_source_face_map, FACE_COUNT);
    if 0 < FACE_COUNT {
        for i_3: 0..FACE_COUNT - 1 {
            assignment_94: u32 =
                ((cast(**u32) *(index_explicit_7(
                    *parent.face_to_source_face_map,
                    ((cast(**u32) *(index_explicit_12(*local_faces_2, i_3))).*).*
                ))).*).*;
            (((cast(**u32) *(index_explicit(*chart.face_to_source_face_map, i_3))).*).*) = assignment_94;
        }
    }

    chart_mesh_indices := *buffers.chart_mesh_indices;
    resize(chart_mesh_indices, vertex_count(source_mesh));
    fill_bytes(chart_mesh_indices, 0xff);
    chart.unified_mesh =
        (ifx true {
        cpp_transpiler_new_g215 :=
            cast(*Internal_Mesh) (cast(*void) (cast(*Internal_Mesh) internal_realloc(
                null,
                360,
                cast(s32) INTERNAL_MEM_TAG_MESH,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                7203
            )));
        init(
            cpp_transpiler_new_g215,
            epsilon(source_mesh),
            size(*chart.face_to_source_face_map) * 3,
            size(*chart.face_to_source_face_map),
            0,
            4294967295
        );
        cpp_transpiler_new_g215;
    })
;
    source_vertex_to_unified_vertex_map: Hash_Map(u32, Passthrough_Hash(u32), Equal(u32)) = ---;
    defer deinit(*source_vertex_to_unified_vertex_map);
    init(
        *source_vertex_to_unified_vertex_map,
        cast(s32) INTERNAL_MEM_TAG_MESH,
        size(*chart.face_to_source_face_map) * 3
    );

    if 0 < FACE_COUNT {
        for f_2: 0..FACE_COUNT - 1 {
            for i_2: 0..cast(u32) 3 - 1 {
                VERTEX_2 :=
                    vertex_at(
                        source_mesh,
                        (((cast(**u32) *(index_explicit(*chart.face_to_source_face_map, f_2))).*).* * 3) + i_2
                    );
                SOURCE_UNIFIED_VERTEX := first_colocal_vertex(source_mesh, VERTEX_2);
                PARENT_VERTEX :=
                    vertex_at(
                        parent_mesh,
                        (((cast(**u32) *(index_explicit_12(*local_faces_2, f_2))).*).* * 3) + i_2
                    );
                unified_vertex := get(*source_vertex_to_unified_vertex_map, *SOURCE_UNIFIED_VERTEX);
                if unified_vertex == 4294967295 {
                    unified_vertex = add(*source_vertex_to_unified_vertex_map, *SOURCE_UNIFIED_VERTEX);
                    add_vertex(
                        chart.unified_mesh,
                        position(source_mesh, VERTEX_2),
                        (ifx true { temporary___g0: Vector3 = make_vector3(0.0); *temporary___g0; }),
                        index_explicit_13(*local_texcoords_3, PARENT_VERTEX)
                    );
                }
                if ((cast(**u32) *(index_explicit(chart_mesh_indices, VERTEX_2))).*).* == 4294967295 {
                    assignment_95: u32 = chart.original_vertex_count;
                    (((cast(**u32) *(index_explicit(chart_mesh_indices, VERTEX_2))).*).*) = assignment_95;
                    chart.original_vertex_count += 1;
                    push_back(*chart.vertex_to_source_vertex_map, *VERTEX_2);
                    push_back(*chart.chart_vertex_to_unified_vertex_map, *unified_vertex);
                }
            }
        }
    }

    resize(*chart.original_indices, FACE_COUNT * 3);
    if 0 < FACE_COUNT {
        for f: 0..FACE_COUNT - 1 {
            unified_indices: [3] u32 = ---;
            for i: 0..cast(u32) 3 - 1 {
                VERTEX :=
                    vertex_at(
                        source_mesh,
                        (((cast(**u32) *(index_explicit(*chart.face_to_source_face_map, f))).*).* * 3) + i
                    );
                assignment_96: u32 = ((cast(**u32) *(index_explicit(chart_mesh_indices, VERTEX))).*).*;
                (((cast(**u32) *(index_explicit(*chart.original_indices, (f * 3) + i))).*).*) = assignment_96;
                UNIFIED_VERTEX := first_colocal_vertex(source_mesh, VERTEX);
                unified_indices[i] = get(*source_vertex_to_unified_vertex_map, *UNIFIED_VERTEX);
            }
            add_face(chart.unified_mesh, unified_indices.data, false, 4294967295);
        }
    }
    create_boundaries(chart.unified_mesh);

    backup_texcoords(chart);
}

init :: (using create_and_parameterize_chart_task_args: *Create_And_Parameterize_Chart_Task_Args) {
    init(*charts, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    assignment_97: Const_Array_View(u32) = Const_Array_View(u32).{};
    ((*faces).*) = assignment_97;
}

init :: (
    using chart_group: *Chart_Group,
    _id: u32,
    _source_mesh: *Internal_Mesh,
    _source_mesh_face_groups: *Mesh_Face_Groups,
    _face_group: Mesh_Face_Groups_Handle
) {
    id = _id;
    source_mesh = _source_mesh;
    source_mesh_face_groups = _source_mesh_face_groups;
    face_group = _face_group;
    init(*face_to_source_face_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*charts, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using atlas: *Param_Atlas) {
    init(*meshes, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*invalid_mesh_geometry, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*mesh_chart_groups, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    charts_computed = false;
}

deinit :: (using atlas: *Param_Atlas) {
    cpp_transpiler_subobject_cleanup_g216: bool = ---;
    defer deinit(*meshes);
    cpp_transpiler_subobject_cleanup_g217: bool = ---;
    defer deinit(*invalid_mesh_geometry);
    cpp_transpiler_subobject_cleanup_g218: bool = ---;
    defer deinit(*mesh_chart_groups);
    {
        i: u32 = 0;
        while i < size(*mesh_chart_groups) {
            {
                j: u32 = 0;
                while j < size(index_explicit_56(*mesh_chart_groups, i)) {
                    deinit((cast(**Chart_Group) index_explicit_52(index_explicit_56(*mesh_chart_groups, i), j)).*);
                    internal_realloc(
                        cast(*void) ((cast(**Chart_Group) index_explicit_52(index_explicit_56(*mesh_chart_groups, i), j)).*),
                        0,
                        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                        7875
                    );
                    j += 1;
                }
            }
            i += 1;
        }
    }
    run_dtors(*mesh_chart_groups);
    run_dtors(*invalid_mesh_geometry);
}

init :: (atlas_image: *Atlas_Image, _width: u32, _height: u32) {
    atlas_image.width = _width;
    atlas_image.height = _height;
    init(*atlas_image.data, cast(s32) INTERNAL_MEM_TAG_DEFAULT);

    resize(*atlas_image.data, atlas_image.width * atlas_image.height);
    fill_memory(data(*atlas_image.data), 0, 4 * cast(u64) size(*atlas_image.data));
}

init :: (using chart: *Pack_Chart) {
    assignment_98: Const_Array_View(u32) = Const_Array_View(u32).{};
    ((*indices).*) = assignment_98;
    assignment_99: Array_View(Vector2) = Array_View(Vector2).{};
    ((*vertices).*) = assignment_99;
    init(*unique_vertices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*major_axis);
    init(*minor_axis);
    init(*min_corner);
    init(*max_corner);
    init(*faces, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

deinit :: (using atlas: *Pack_Atlas) {
    cpp_transpiler_subobject_cleanup_g219: bool = ---;
    defer deinit(*atlas_images);
    cpp_transpiler_subobject_cleanup_g220: bool = ---;
    defer deinit(*utilization);
    cpp_transpiler_subobject_cleanup_g221: bool = ---;
    defer deinit(*bit_images);
    cpp_transpiler_subobject_cleanup_g222: bool = ---;
    defer deinit(*charts);
    cpp_transpiler_subobject_cleanup_g223: bool = ---;
    defer deinit(*radix);
    {
        i_3: u32 = 0;
        while i_3 < size(*atlas_images) {
            deinit((cast(**Atlas_Image) index_explicit_30(*atlas_images, i_3)).*);
            internal_realloc(
                cast(*void) ((cast(**Atlas_Image) index_explicit_30(*atlas_images, i_3)).*),
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                8144
            );
            i_3 += 1;
        }
    }
    {
        i_2: u32 = 0;
        while i_2 < size(*bit_images) {
            deinit((cast(**Bit_Image) index_explicit_28(*bit_images, i_2)).*);
            internal_realloc(
                cast(*void) ((cast(**Bit_Image) index_explicit_28(*bit_images, i_2)).*),
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                8148
            );
            i_2 += 1;
        }
    }
    {
        i: u32 = 0;
        while i < size(*charts) {
            deinit((cast(**Pack_Chart) index_explicit_3(*charts, i)).*);
            internal_realloc(
                cast(*void) ((cast(**Pack_Chart) index_explicit_3(*charts, i)).*),
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                8152
            );
            i += 1;
        }
    }
}

init :: (using atlas: *Pack_Atlas) {
    init(*atlas_images, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*utilization, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*bit_images, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*charts, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*radix);

    width = 0;
    height = 0;
    texels_per_unit = 0.0;
    init(*rand);
}

init :: (using mesh_polygon_mapping: *Mesh_Polygon_Mapping) {
    init(*face_vertex_count, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*triangle_to_polygon_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*triangle_to_polygon_indices_map, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
}

init :: (using context_value: *Context) {

    add_mesh_progress = cast(*Progress) null;
    init(*add_mesh_task_group);
    init(*param_atlas);

    progress_func = cast(Progress_Func) null;
    progress_user_data = null;
    init_2(*meshes, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*mesh_polygon_mappings, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*uv_meshes, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    init(*uv_mesh_instances, cast(s32) INTERNAL_MEM_TAG_DEFAULT);

    uv_mesh_charts_computed = false;
}

create :: () -> *Atlas {
    ctx :=
        cast(*Context) (cast(*void) (cast(*Context) internal_realloc(
            null,
            272,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            8896
        )));
    init(ctx);
    fill_memory(*ctx.atlas, 0, 48);
    ctx.task_scheduler =
        (ifx true {
        cpp_transpiler_new_g224 :=
            cast(*Task_Scheduler) (cast(*void) (cast(*Task_Scheduler) internal_realloc(
                null,
                24,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                8898
            )));
        init(cpp_transpiler_new_g224);
        cpp_transpiler_new_g224;
    })
;
    return *ctx.atlas;
}

destroy :: (atlas: *Atlas) {
    assert(atlas != null);
    ctx := cast(*Context) atlas;
    if atlas.utilization != null {
        internal_realloc(
            cast(*void) atlas.utilization,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            8929
        );
    }
    if atlas.image != null {
        internal_realloc(
            cast(*void) atlas.image,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            8931
        );
    }
    destroy_output_meshes(ctx);
    if ctx.add_mesh_progress != null {
        assign_in_xatlas(*ctx.add_mesh_progress.cancel, true);
        add_mesh_join(atlas);
    }
    deinit(ctx.task_scheduler);
    internal_realloc(
        cast(*void) ctx.task_scheduler,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        8938
    );
    {
        i_4: u32 = 0;
        while i_4 < size_2(*ctx.meshes) {
            mesh_3: *Internal_Mesh =
                cast,no_check(*Internal_Mesh) ((cast(**Internal_Mesh) index_explicit_57(*ctx.meshes, i_4)).*);
            deinit(mesh_3);
            internal_realloc(
                cast(*void) mesh_3,
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                8942
            );
            i_4 += 1;
        }
    }
    {
        i_3: u32 = 0;
        while i_3 < size(*ctx.mesh_polygon_mappings) {
            mapping: *Mesh_Polygon_Mapping =
                cast,no_check(*Mesh_Polygon_Mapping) ((cast(**Mesh_Polygon_Mapping) index_explicit_22(*ctx.mesh_polygon_mappings, i_3)).*);
            if mapping != null {
                deinit(mapping);
                internal_realloc(
                    cast(*void) mapping,
                    0,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    8948
                );
            }
            i_3 += 1;
        }
    }
    {
        i_2: u32 = 0;
        while i_2 < size(*ctx.uv_meshes) {
            mesh_2: *Uv_Mesh = cast,no_check(*Uv_Mesh) ((cast(**Uv_Mesh) index_explicit_37(*ctx.uv_meshes, i_2)).*);
            {
                j: u32 = 0;
                while j < size(*mesh_2.charts) {
                    deinit((cast(**Uv_Mesh_Chart) index_explicit_36(*mesh_2.charts, j)).*);
                    internal_realloc(
                        cast(*void) ((cast(**Uv_Mesh_Chart) index_explicit_36(*mesh_2.charts, j)).*),
                        0,
                        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                        8955
                    );
                    j += 1;
                }
            }
            deinit(mesh_2);
            internal_realloc(
                cast(*void) mesh_2,
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                8958
            );
            i_2 += 1;
        }
    }
    {
        i: u32 = 0;
        while i < size(*ctx.uv_mesh_instances) {
            mesh: *Uv_Mesh_Instance =
                cast,no_check(*Uv_Mesh_Instance) ((cast(**Uv_Mesh_Instance) index_explicit_17(*ctx.uv_mesh_instances, i)).*);
            deinit(mesh);
            internal_realloc(
                cast(*void) mesh,
                0,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                8963
            );
            i += 1;
        }
    }
    deinit(ctx);
    internal_realloc(
        cast(*void) ctx,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        8966
    );
}

add_mesh_join :: (atlas: *Atlas) {
    assert(atlas != null);
    if atlas == null {
        if s_print != null {
            s_print(c_string("AddMeshJoin: atlas is null.\n"));
        }

        return;
    }
    ctx := cast(*Context) atlas;
    if is_empty(*ctx.uv_meshes) {
        if ctx.add_mesh_progress == null {
            return;
        }
        wait(ctx.task_scheduler, *ctx.add_mesh_task_group);
        deinit(ctx.add_mesh_progress);
        internal_realloc(
            cast(*void) ctx.add_mesh_progress,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            9238
        );
        ctx.add_mesh_progress = cast(*Progress) null;
    }
}

destroy_output_meshes :: (ctx: *Context) {
    if ctx.atlas.meshes == null {
        return;
    }
    {
        i: s32 = 0;
        while i < cast,no_check(s32) ctx.atlas.mesh_count {
            mesh := *ctx.atlas.meshes[i];
            if mesh.chart_array != null {
                {
                    j: u32 = 0;
                    while j < mesh.chart_count {
                        if mesh.chart_array[j].face_array != null {
                            internal_realloc(
                                cast(*void) mesh.chart_array[j].face_array,
                                0,
                                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                                8911
                            );
                        }
                        j += 1;
                    }
                }
                internal_realloc(
                    cast(*void) mesh.chart_array,
                    0,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    8913
                );
            }
            if mesh.vertex_array != null {
                internal_realloc(
                    cast(*void) mesh.vertex_array,
                    0,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    8916
                );
            }
            if mesh.index_array != null {
                internal_realloc(
                    cast(*void) mesh.index_array,
                    0,
                    cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                    c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                    8918
                );
            }
            i += 1;
        }
    }
    internal_realloc(
        cast(*void) ctx.atlas.meshes,
        0,
        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
        8920
    );
    ctx.atlas.meshes = cast(*Mesh) null;
}

add_mesh :: (atlas: *Atlas, mesh_decl: *Mesh_Decl, mesh_count_hint: u32) -> Add_Mesh_Error {
    assert(atlas != null);
    if atlas == null {
        if s_print != null {
            s_print(c_string("AddMesh: atlas is null.\n"));
        }

        return ADD_MESH_ERROR_ERROR;
    }
    ctx := cast(*Context) atlas;
    if !is_empty(*ctx.uv_meshes) {
        if s_print != null {
            s_print(c_string("AddMesh: Meshes and UV meshes cannot be added to the same atlas.\n"));
        }

        return ADD_MESH_ERROR_ERROR;
    }

    if ctx.add_mesh_progress == null {
        ctx.add_mesh_progress =
            (ifx true {
        cpp_transpiler_new_g225 :=
            cast(*Progress) (cast(*void) (cast(*Progress) internal_realloc(
                null,
                40,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                9040
            )));
        init(
            cpp_transpiler_new_g225,
            PROGRESS_CATEGORY_ADD_MESH,
            cast,no_check(Progress_Func) (ctx.progress_func),
            ctx.progress_user_data,
            1
        );
        cpp_transpiler_new_g225;
    })
;
    } else {
        set_max_value(
            ctx.add_mesh_progress,
            internal_max((ifx true { temporary___g0: u32 = (size_2(*ctx.meshes) +
            1); *temporary___g0; }), *mesh_count_hint)
        );
    }

    HAS_INDICES := mesh_decl.index_count > 0;
    INDEX_COUNT := (ifx HAS_INDICES then mesh_decl.index_count else mesh_decl.vertex_count);
    face_count_2 := INDEX_COUNT / 3;
    if mesh_decl.face_vertex_count != null {
        face_count_2 = mesh_decl.face_count;
        if s_print != null && s_print_verbose {
            s_print(
                c_string("Adding mesh %d: %u vertices, %u polygons\n"),
                size_2(*ctx.meshes),
                mesh_decl.vertex_count,
                face_count_2
            );
        }

        if 0 < face_count_2 {
            for f: 0..face_count_2 - 1 {
                if mesh_decl.face_vertex_count[f] < 3 {
                    return ADD_MESH_ERROR_INVALID_FACE_VERTEX_COUNT;
                }
            }
        }
    } else {
        if s_print != null && s_print_verbose {
            s_print(
                c_string("Adding mesh %d: %u vertices, %u triangles\n"),
                size_2(*ctx.meshes),
                mesh_decl.vertex_count,
                face_count_2
            );
        }

        if (INDEX_COUNT % 3) != 0 {
            return ADD_MESH_ERROR_INVALID_INDEX_COUNT;
        }
    }
    mesh_flags := INTERNAL_MESH_FLAGS_HAS_IGNORED_FACES;
    if mesh_decl.vertex_normal_data != null {
        mesh_flags |= INTERNAL_MESH_FLAGS_HAS_NORMALS;
    }
    if mesh_decl.face_material_data != null {
        mesh_flags |= INTERNAL_MESH_FLAGS_HAS_MATERIALS;
    }
    mesh :=
        cast(*Internal_Mesh) (cast(*void) (cast(*Internal_Mesh) internal_realloc(
            null,
            360,
            cast(s32) INTERNAL_MEM_TAG_MESH,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            9067
        )));
    init(mesh, mesh_decl.epsilon, mesh_decl.vertex_count, INDEX_COUNT / 3, mesh_flags, size_2(*ctx.meshes));
    {
        i_6: u32 = 0;
        while i_6 < mesh_decl.vertex_count {
            normal_2 := make_vector3(0.0);
            texcoord_3 := make_vector2(0.0);
            if mesh_decl.vertex_normal_data != null {
                assign_9(
                    *normal_2,
                    (ifx true { temporary___g1: Vector3 = decode_normal(mesh_decl, i_6); *temporary___g1; })
                );
            }
            if mesh_decl.vertex_uv_data != null {
                assign(*texcoord_3, (ifx true { temporary___g2: Vector2 = decode_uv(mesh_decl, i_6); *temporary___g2; }));
            }
            add_vertex(
                mesh,
                (ifx true { temporary___g4: Vector3 = decode_position(mesh_decl, i_6); *temporary___g4; }),
                *normal_2,
                *texcoord_3
            );
            i_6 += 1;
        }
    }
    mesh_polygon_mapping: *Mesh_Polygon_Mapping = cast(*Mesh_Polygon_Mapping) null;
    if mesh_decl.face_vertex_count != null {
        mesh_polygon_mapping =
            (ifx true {
        cpp_transpiler_new_g226 :=
            cast(*Mesh_Polygon_Mapping) (cast(*void) (cast(*Mesh_Polygon_Mapping) internal_realloc(
                null,
                72,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                9079
            )));
        init(cpp_transpiler_new_g226);
        cpp_transpiler_new_g226;
    })
;

        copy_from(*mesh_polygon_mapping.face_vertex_count, mesh_decl.face_vertex_count, mesh_decl.face_count);

        reserve(*mesh_polygon_mapping.triangle_to_polygon_map, mesh_decl.face_count);
        reserve(*mesh_polygon_mapping.triangle_to_polygon_indices_map, mesh_decl.index_count);
    }
    K_MAX_WARNINGS: u32 = 50;
    warning_count: u32 = 0;
    tri_indices: Array(u32) = ---;
    defer deinit(*tri_indices);
    init(*tri_indices, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    triangulator: Triangulator = ---;
    defer deinit(*triangulator);
    init(*triangulator);
    {
        face_2: u32 = 0;
        while face_2 < face_count_2 {
            FACE_VERTEX_COUNT :=
                (ifx mesh_decl.face_vertex_count != null then cast,no_check(u32) mesh_decl.face_vertex_count[face_2] else 3);
            polygon: [255] u32 = ---;
            if 0 < FACE_VERTEX_COUNT {
                for i_7: 0..FACE_VERTEX_COUNT - 1 {
                    if HAS_INDICES {
                        polygon[i_7] =
                            decode_index(
                                mesh_decl.index_format,
                                mesh_decl.index_data,
                                mesh_decl.index_offset,
                                face_2 * FACE_VERTEX_COUNT + i_7
                            );

                        if polygon[i_7] >= mesh_decl.vertex_count {
                            deinit(mesh);
                            internal_realloc(
                                cast(*void) mesh,
                                0,
                                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                                9100
                            );
                            return ADD_MESH_ERROR_INDEX_OUT_OF_RANGE;
                        }
                    } else {
                        polygon[i_7] = face_2 * FACE_VERTEX_COUNT + i_7;
                    }
                }
            }

            ignore: bool = false;
            if 0 < FACE_VERTEX_COUNT {
                for i_5: 0..FACE_VERTEX_COUNT - 1 {
                    INDEX1 := polygon[i_5];
                    INDEX2 := polygon[(i_5 + 1) % 3];
                    if INDEX1 == INDEX2 {
                        ignore = true;
                        if c_transpiler_pre_increment(*(warning_count)) <= K_MAX_WARNINGS {
                            if s_print != null && s_print_verbose {
                                s_print(c_string("   Degenerate edge: index %d, index %d\n"), INDEX1, INDEX2);
                            }
                        }

                        break;
                    }
                    pos1: *Vector3 = cast,no_check(*Vector3) position(mesh, INDEX1);
                    pos2: *Vector3 = cast,no_check(*Vector3) position(mesh, INDEX2);
                    if internal_length(
                        (ifx true { temporary___g3: Vector3 = internal_operator_in_xatlas_2(pos2, pos1); *temporary___g3; })
                    ) <= 0.0 {
                        ignore = true;
                        if c_transpiler_pre_increment(*(warning_count)) <= K_MAX_WARNINGS {
                            if s_print != null && s_print_verbose {
                                s_print(
                                    c_string("   Zero length edge: index %d position (%g %g %g), index %d position (%g %g %g)\n"),
                                    INDEX1,
                                    cast,no_check(float64) pos1.x,
                                    cast,no_check(float64) pos1.y,
                                    cast,no_check(float64) pos1.z,
                                    INDEX2,
                                    cast,no_check(float64) pos2.x,
                                    cast,no_check(float64) pos2.y,
                                    cast,no_check(float64) pos2.z
                                );
                            }
                        }

                        break;
                    }
                }
            }

            if !ignore {
                if 0 < FACE_VERTEX_COUNT {
                    for i_4: 0..FACE_VERTEX_COUNT - 1 {
                        pos: *Vector3 = cast,no_check(*Vector3) position(mesh, polygon[i_4]);
                        if internal_is_nan(pos.x) || internal_is_nan(pos.y) || internal_is_nan(pos.z) {
                            if c_transpiler_pre_increment(*(warning_count)) <= K_MAX_WARNINGS {
                                if s_print != null && s_print_verbose {
                                    s_print(c_string("   NAN position in face: %d\n"), face_2);
                                }
                            }

                            ignore = true;
                            break;
                        }
                        if mesh_decl.vertex_normal_data != null {
                            normal_3: *Vector3 = cast,no_check(*Vector3) normal(mesh, polygon[i_4]);
                            if internal_is_nan(normal_3.x) || internal_is_nan(normal_3.y) || internal_is_nan(normal_3.z) {
                                if c_transpiler_pre_increment(*(warning_count)) <= K_MAX_WARNINGS {
                                    if s_print != null && s_print_verbose {
                                        s_print(c_string("   NAN normal in face: %d\n"), face_2);
                                    }
                                }

                                ignore = true;
                                break;
                            }
                        }
                        if mesh_decl.vertex_uv_data != null {
                            uv: *Vector2 = cast,no_check(*Vector2) texcoord(mesh, polygon[i_4]);
                            if internal_is_nan(uv.x) || internal_is_nan(uv.y) {
                                if c_transpiler_pre_increment(*(warning_count)) <= K_MAX_WARNINGS {
                                    if s_print != null && s_print_verbose {
                                        s_print(c_string("   NAN texture coordinate in face: %d\n"), face_2);
                                    }
                                }

                                ignore = true;
                                break;
                            }
                        }
                    }
                }
            }

            clear(*tri_indices);
            if FACE_VERTEX_COUNT == 3 {
                push_back(*tri_indices, polygon.data + 0);
                push_back(*tri_indices, polygon.data + 1);
                push_back(*tri_indices, polygon.data + 2);
            } else {
                triangulate_polygon(
                    *triangulator,
                    positions(mesh),
                    make_struct_xatlas_internal_const_array_view_unsigned_int(polygon.data, FACE_VERTEX_COUNT),
                    *tri_indices
                );
            }

            if !ignore {
                {
                    i_3: u32 = 0;
                    while i_3 < size(*tri_indices) {
                        a: *Vector3 =
                            cast,no_check(*Vector3) position(
                                mesh,
                                ((cast(**u32) *(index_explicit(*tri_indices, i_3 + 0))).*).*
                            );
                        b: *Vector3 =
                            cast,no_check(*Vector3) position(
                                mesh,
                                ((cast(**u32) *(index_explicit(*tri_indices, i_3 + 1))).*).*
                            );
                        c_: *Vector3 =
                            cast,no_check(*Vector3) position(
                                mesh,
                                ((cast(**u32) *(index_explicit(*tri_indices, i_3 + 2))).*).*
                            );
                        AREA :=
                            internal_length(
                                (ifx true { temporary___g8: Vector3 = internal_cross(
                                (ifx true { temporary___g6: Vector3 = internal_operator_in_xatlas_2(b, a); *temporary___g6; }),
                                (ifx true { temporary___g5: Vector3 = internal_operator_in_xatlas_2(c_, a); *temporary___g5; })
                            ); *temporary___g8; })
                            ) * 0.5;
                        if AREA <= K_AREA_EPSILON {
                            ignore = true;
                            if c_transpiler_pre_increment(*(warning_count)) <= K_MAX_WARNINGS {
                                if s_print != null && s_print_verbose {
                                    s_print(
                                        c_string("   Zero area face: %d, area is %f\n"),
                                        face_2,
                                        cast,no_check(float64) AREA
                                    );
                                }
                            }

                            break;
                        }
                        i_3 += 3;
                    }
                }
            }

            if mesh_decl.face_ignore_data != null && mesh_decl.face_ignore_data[face_2] {
                ignore = true;
            }

            material: u32 = 4294967295;
            if mesh_decl.face_material_data != null {
                material = mesh_decl.face_material_data[face_2];
            }

            {
                i_2: u32 = 0;
                while i_2 < size(*tri_indices) {
                    add_face(mesh, (cast(**u32) *(index_explicit(*tri_indices, i_2))).*, ignore, material);
                    if mesh_polygon_mapping != null {
                        push_back(*mesh_polygon_mapping.triangle_to_polygon_map, *face_2);
                    }
                    i_2 += 3;
                }
            }
            if mesh_polygon_mapping != null {
                {
                    i: u32 = 0;
                    while i < size(*tri_indices) {
                        push_back(
                            *mesh_polygon_mapping.triangle_to_polygon_indices_map,
                            index_explicit(*tri_indices, i)
                        );
                        i += 1;
                    }
                }
            }
            face_2 += 1;
        }
    }
    if warning_count > K_MAX_WARNINGS {
        if s_print != null && s_print_verbose {
            s_print(c_string("   %u additional warnings truncated\n"), warning_count - K_MAX_WARNINGS);
        }
    }

    push_back_2(*ctx.meshes, *mesh);
    push_back(*ctx.mesh_polygon_mappings, *mesh_polygon_mapping);
    add_mesh(*ctx.param_atlas, mesh);
    if ctx.add_mesh_task_group.value == 4294967295 {
        ctx.add_mesh_task_group = create_task_group(ctx.task_scheduler, cast(*void) ctx, 0);
    }
    task: Task = ---;
    task.user_data = cast(*void) mesh;
    task.func = run_add_mesh_task;
    run(ctx.task_scheduler, ctx.add_mesh_task_group, task);
    return ADD_MESH_ERROR_SUCCESS;
}

run_add_mesh_task :: (group_user_data: *void, task_user_data: *void) {
    ctx := cast(*Context) group_user_data;
    mesh := cast(*Internal_Mesh) task_user_data;
    progress := ctx.add_mesh_progress;
    if operator_bool(*progress.cancel) {
        return;
    }

    create_colocals(mesh);

    if operator_bool(*progress.cancel) {
        return;
    }
    increment(progress, 1);
}

decode_index :: (format: Index_Format, index_data: *void, offset: s32, i: u32) -> u32 {
    assert(index_data != null);
    if format == INDEX_FORMAT_U_INT16 {
        return cast,no_check(u32) (cast,no_check(u16) ((cast,no_check(s32) ((cast(*u16) index_data)[i])) + offset));
    }
    return cast,no_check(u32) ((cast,no_check(s32) ((cast(*u32) index_data)[i])) + offset);
}

add_uv_mesh :: (atlas: *Atlas, decl: *Uv_Mesh_Decl) -> Add_Mesh_Error {
    assert(atlas != null);
    if atlas == null {
        if s_print != null {
            s_print(c_string("AddUvMesh: atlas is null.\n"));
        }

        return ADD_MESH_ERROR_ERROR;
    }
    ctx := cast(*Context) atlas;
    if !is_empty(*ctx.meshes) {
        if s_print != null {
            s_print(c_string("AddUvMesh: Meshes and UV meshes cannot be added to the same atlas.\n"));
        }

        return ADD_MESH_ERROR_ERROR;
    }

    HAS_INDICES := decl.index_count > 0;
    INDEX_COUNT := (ifx HAS_INDICES then decl.index_count else decl.vertex_count);
    if s_print != null && s_print_verbose {
        s_print(
            c_string("Adding UV mesh %d: %u vertices, %u triangles\n"),
            size(*ctx.uv_meshes),
            decl.vertex_count,
            INDEX_COUNT / 3
        );
    }

    if (INDEX_COUNT % 3) != 0 {
        return ADD_MESH_ERROR_INVALID_INDEX_COUNT;
    }
    if HAS_INDICES {
        if 0 < INDEX_COUNT {
            for i_5: 0..INDEX_COUNT - 1 {
                INDEX := decode_index(decl.index_format, decl.index_data, decl.index_offset, i_5);
                if INDEX >= decl.vertex_count {
                    return ADD_MESH_ERROR_INDEX_OUT_OF_RANGE;
                }
            }
        }
    }

    mesh_instance :=
        cast(*Uv_Mesh_Instance) (cast(*void) (cast(*Uv_Mesh_Instance) internal_realloc(
            null,
            32,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            9290
        )));
    init(mesh_instance);
    mesh_instance.mesh = cast(*Uv_Mesh) null;
    push_back(*ctx.uv_mesh_instances, *mesh_instance);

    mesh: *Uv_Mesh = cast(*Uv_Mesh) null;
    {
        m: u32 = 0;
        while m < size(*ctx.uv_meshes) {
            if c_transpiler_memcmp(
                cast(*void) (*(((cast(**Uv_Mesh) index_explicit_37(*ctx.uv_meshes, m)).*).decl)),
                cast(*void) ((cast(**Uv_Mesh_Decl) *(decl)).*),
                48
            ) == 0 {
                mesh = cast,no_check(*Uv_Mesh) ((cast(**Uv_Mesh) index_explicit_37(*ctx.uv_meshes, m)).*);
                if s_print != null && s_print_verbose {
                    s_print(c_string("   instance of a previous UV mesh\n"));
                }

                break;
            }
            m += 1;
        }
    }
    if mesh == null {
        mesh =
            (ifx true {
        cpp_transpiler_new_g227 :=
            cast(*Uv_Mesh) (cast(*void) (cast(*Uv_Mesh) internal_realloc(
                null,
                200,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                9304
            )));
        init(cpp_transpiler_new_g227);
        cpp_transpiler_new_g227;
    })
;
        push_back(*ctx.uv_meshes, *mesh);
        mesh.decl = (decl).*;
        if decl.face_material_data != null {
            resize(*mesh.face_materials, decl.index_count / 3);
            copy_memory(data(*mesh.face_materials), decl.face_material_data, (cast(u64) size(*mesh.face_materials)) * 4);
        }
        resize(*mesh.indices, decl.index_count);
        if 0 < INDEX_COUNT {
            for i_4: 0..INDEX_COUNT - 1 {
                assignment_100: u32 =
                    (ifx HAS_INDICES then decode_index(decl.index_format, decl.index_data, decl.index_offset, i_4) else i_4);
                (((cast(**u32) *(index_explicit(*mesh.indices, i_4))).*).*) = assignment_100;
            }
        }
        resize(*mesh.texcoords, decl.vertex_count);
        {
            i_3: u32 = 0;
            while i_3 < decl.vertex_count {
                assign_3(
                    index_explicit_4(*mesh.texcoords, i_3),
                    cast(*Vector2) (*(cast(*u8) decl.vertex_uv_data)[decl.vertex_stride * i_3])
                );
                i_3 += 1;
            }
        }

        resize(*mesh.face_ignore, decl.index_count / 3);
        zero_out_memory(*mesh.face_ignore);
        K_MAX_WARNINGS: u32 = 50;
        warning_count: u32 = 0;
        {
            f: u32 = 0;
            while f < INDEX_COUNT / 3 {
                ignore: bool = false;
                tri: [3] u32 = ---;
                for i_2: 0..cast(u32) 3 - 1 {
                    tri[i_2] = ((cast(**u32) *(index_explicit(*mesh.indices, (f * 3) + i_2))).*).*;
                }

                for i: 0..cast(u32) 3 - 1 {
                    VERTEX := tri[i];
                    if internal_is_nan((index_explicit_4(*mesh.texcoords, VERTEX)).x) ||
                        internal_is_nan((index_explicit_4(*mesh.texcoords, VERTEX)).y) {
                        ignore = true;
                        if c_transpiler_pre_increment(*(warning_count)) <= K_MAX_WARNINGS {
                            if s_print != null && s_print_verbose {
                                s_print(c_string("   NAN texture coordinate in vertex %u\n"), VERTEX);
                            }
                        }

                        break;
                    }
                }

                if !ignore {
                    v1: *Vector2 = cast,no_check(*Vector2) index_explicit_4(*mesh.texcoords, tri[0]);
                    v2: *Vector2 = cast,no_check(*Vector2) index_explicit_4(*mesh.texcoords, tri[1]);
                    v3: *Vector2 = cast,no_check(*Vector2) index_explicit_4(*mesh.texcoords, tri[2]);
                    AREA := fabsf(((v2.x - v1.x) * (v3.y - v1.y) - (v3.x - v1.x) * (v2.y - v1.y)) * 0.5);
                    if AREA <= K_AREA_EPSILON {
                        ignore = true;
                        if c_transpiler_pre_increment(*(warning_count)) <= K_MAX_WARNINGS {
                            if s_print != null && s_print_verbose {
                                s_print(
                                    c_string("   Zero area face: %d, indices (%d %d %d), area is %f\n"),
                                    f,
                                    tri[0],
                                    tri[1],
                                    tri[2],
                                    cast,no_check(float64) AREA
                                );
                            }
                        }
                    }
                }
                if ignore {
                    set(*mesh.face_ignore, f);
                }
                f += 1;
            }
        }
        if warning_count > K_MAX_WARNINGS {
            if s_print != null && s_print_verbose {
                s_print(c_string("   %u additional warnings truncated\n"), warning_count - K_MAX_WARNINGS);
            }
        }
    }
    mesh_instance.mesh = cast,no_check(*Uv_Mesh) mesh;

    return ADD_MESH_ERROR_SUCCESS;
}

compute_charts :: (atlas: *Atlas, options_: Chart_Options) {
    local_options_: Chart_Options = options_;
    if atlas == null {
        if s_print != null {
            s_print(c_string("ComputeCharts: atlas is null.\n"));
        }

        return;
    }
    ctx := cast(*Context) atlas;
    add_mesh_join(atlas);
    if is_empty(*ctx.meshes) && is_empty(*ctx.uv_mesh_instances) {
        if s_print != null {
            s_print(c_string("ComputeCharts: No meshes. Call AddMesh or AddUvMesh first.\n"));
        }

        return;
    }

    if atlas.utilization != null {
        internal_realloc(
            cast(*void) atlas.utilization,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            9374
        );
    }
    if atlas.image != null {
        internal_realloc(
            cast(*void) atlas.image,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            9376
        );
    }
    destroy_output_meshes(ctx);
    fill_memory(*ctx.atlas, 0, 48);
    if s_print != null && s_print_verbose {
        s_print(c_string("Computing charts\n"));
    }

    if !is_empty(*ctx.meshes) {
        if !compute_charts(
            *ctx.param_atlas,
            ctx.task_scheduler,
            *local_options_,
            cast,no_check(Progress_Func) (ctx.progress_func),
            ctx.progress_user_data
        ) {
            if s_print != null && s_print_verbose {
                s_print(c_string("   Cancelled by user\n"));
            }

            return;
        }
        charts_with_t_junctions_count: u32 = 0;
        t_junction_count: u32 = 0;
        ortho_charts_count: u32 = 0;
        planar_charts_count: u32 = 0;
        lscm_charts_count: u32 = 0;
        piecewise_charts_count: u32 = 0;
        original_uv_charts_count: u32 = 0;
        chart_count_3: u32 = 0;
        MESH_COUNT_2 := size_2(*ctx.meshes);
        if 0 < MESH_COUNT_2 {
            for i_3: 0..MESH_COUNT_2 - 1 {
                {
                    j_2: u32 = 0;
                    while j_2 < chart_group_count(*ctx.param_atlas, i_3) {
                        chart_group_2: *Chart_Group =
                            cast,no_check(*Chart_Group) chart_group_at(*ctx.param_atlas, i_3, j_2);
                        {
                            k_2: u32 = 0;
                            while k_2 < chart_count(chart_group_2) {
                                chart_2 := chart_at(chart_group_2, k_2);
                                t_junction_count += tjunction_count(chart_2);
                                if tjunction_count(chart_2) > 0 {
                                    charts_with_t_junctions_count += 1;
                                }
                                if type(chart_2) == CHART_TYPE_PLANAR {
                                    planar_charts_count += 1;
                                } else if type(chart_2) == CHART_TYPE_ORTHO {
                                    ortho_charts_count += 1;
                                } else if type(chart_2) == CHART_TYPE_LSCM {
                                    lscm_charts_count += 1;
                                } else if type(chart_2) == CHART_TYPE_PIECEWISE {
                                    piecewise_charts_count += 1;
                                }
                                if cast,no_check(s32) generator_type(chart_2) == cast(s32) INTERNAL_SEGMENT_CHART_GENERATOR_TYPE_ORIGINAL_UV {
                                    original_uv_charts_count += 1;
                                }
                                k_2 += 1;
                            }
                        }
                        chart_count_3 += chart_count(chart_group_2);
                        j_2 += 1;
                    }
                }
            }
        }
        if t_junction_count > 0 {
            if s_print != null && s_print_verbose {
                s_print(
                    c_string("   %u t-junctions found in %u charts\n"),
                    t_junction_count,
                    charts_with_t_junctions_count
                );
            }
        }

        if s_print != null && s_print_verbose {
            s_print(c_string("   %u charts\n"), chart_count_3);
        }

        if s_print != null && s_print_verbose {
            s_print(
                c_string("      %u planar, %u ortho, %u LSCM, %u piecewise\n"),
                planar_charts_count,
                ortho_charts_count,
                lscm_charts_count,
                piecewise_charts_count
            );
        }

        if original_uv_charts_count > 0 {
            if s_print != null && s_print_verbose {
                s_print(c_string("      %u with original UVs\n"), original_uv_charts_count);
            }
        }

        chart_index: u32 = 0;
        invalid_param_count: u32 = 0;
        {
            i_2: u32 = 0;
            while i_2 < MESH_COUNT_2 {
                {
                    j: u32 = 0;
                    while j < chart_group_count(*ctx.param_atlas, i_2) {
                        chart_group: *Chart_Group =
                            cast,no_check(*Chart_Group) chart_group_at(*ctx.param_atlas, i_2, j);
                        {
                            k: u32 = 0;
                            while k < chart_count(chart_group) {
                                chart: *Param_Chart = cast,no_check(*Param_Chart) chart_at(chart_group, k);
                                quality_2: *Quality = cast,no_check(*Quality) quality(chart);

                                type_2 := c_string("LSCM");
                                if type(chart) == CHART_TYPE_PLANAR {
                                    type_2 = c_string("planar");
                                } else if type(chart) == CHART_TYPE_ORTHO {
                                    type_2 = c_string("ortho");
                                } else if type(chart) == CHART_TYPE_PIECEWISE {
                                    type_2 = c_string("piecewise");
                                }
                                if is_invalid(chart) {
                                    if quality_2.boundary_intersection {
                                        if s_print != null {
                                            s_print(
                                                c_string("   Chart %u (mesh %u, group %u, id %u) (%s): invalid parameterization, self-intersecting boundary.\n"),
                                                chart_index,
                                                i_2,
                                                j,
                                                k,
                                                type_2
                                            );
                                        }
                                    }
                                    if quality_2.flipped_triangle_count > 0 {
                                        if s_print != null {
                                            s_print(
                                                c_string("   Chart %u  (mesh %u, group %u, id %u) (%s): invalid parameterization, %u / %u flipped triangles.\n"),
                                                chart_index,
                                                i_2,
                                                j,
                                                k,
                                                type_2,
                                                quality_2.flipped_triangle_count,
                                                quality_2.total_triangle_count
                                            );
                                        }
                                    }
                                    if quality_2.zero_area_triangle_count > 0 {
                                        if s_print != null {
                                            s_print(
                                                c_string("   Chart %u  (mesh %u, group %u, id %u) (%s): invalid parameterization, %u / %u zero area triangles.\n"),
                                                chart_index,
                                                i_2,
                                                j,
                                                k,
                                                type_2,
                                                quality_2.zero_area_triangle_count,
                                                quality_2.total_triangle_count
                                            );
                                        }
                                    }
                                    invalid_param_count += 1;
                                }
                                chart_index += 1;
                                k += 1;
                            }
                        }
                        j += 1;
                    }
                }
                i_2 += 1;
            }
        }
        if invalid_param_count > 0 {
            if s_print != null {
                s_print(c_string("   %u charts with invalid parameterizations\n"), invalid_param_count);
            }
        }

        if local_options_.use_input_mesh_uvs {
        }
    } else {
        if !internal_segment_compute_uv_mesh_charts(
            ctx.task_scheduler,
            make_struct_xatlas_internal_array_view_struct_xatlas_internal_uv_mesh(*ctx.uv_meshes),
            cast,no_check(Progress_Func) (ctx.progress_func),
            ctx.progress_user_data
        ) {
            if s_print != null && s_print_verbose {
                s_print(c_string("   Cancelled by user\n"));
            }

            return;
        }

        ctx.uv_mesh_charts_computed = true;

        chart_count_2: u32 = 0;
        MESH_COUNT := size(*ctx.uv_meshes);
        if 0 < MESH_COUNT {
            for i: 0..MESH_COUNT - 1 {
                chart_count_2 += size(*(((cast(**Uv_Mesh) index_explicit_37(*ctx.uv_meshes, i)).*).charts));
            }
        }
        if s_print != null && s_print_verbose {
            s_print(c_string("   %u charts\n"), chart_count_2);
        }
    }
}

internal_segment_compute_uv_mesh_charts :: (
    task_scheduler: *Task_Scheduler,
    meshes: Array_View(*Uv_Mesh),
    progress_func: Progress_Func,
    progress_user_data: *void
) -> bool {
    local_meshes: Array_View(*Uv_Mesh) = meshes;
    total_face_count: u32 = 0;
    {
        i_2: u32 = 0;
        while i_2 < local_meshes.length {
            total_face_count += size(*(((cast(**Uv_Mesh) index_explicit_58(*local_meshes, i_2)).*).indices)) / 3;
            i_2 += 1;
        }
    }
    progress: Progress = ---;
    defer deinit(*progress);
    init(
        *progress,
        PROGRESS_CATEGORY_COMPUTE_CHARTS,
        cast,no_check(Progress_Func) (progress_func),
        progress_user_data,
        total_face_count
    );
    task_group := create_task_group(task_scheduler, null, local_meshes.length);
    task_args: Array(Compute_Uv_Mesh_Charts_Task_Args) = ---;
    defer deinit(*task_args);
    init(*task_args, cast(s32) INTERNAL_MEM_TAG_DEFAULT);
    resize(*task_args, local_meshes.length);
    {
        i: u32 = 0;
        while i < local_meshes.length {
            args: *Compute_Uv_Mesh_Charts_Task_Args =
                cast,no_check(*Compute_Uv_Mesh_Charts_Task_Args) index_explicit_59(
                    *task_args,
                    i
                );
            args.mesh = cast,no_check(*Uv_Mesh) ((cast(**Uv_Mesh) index_explicit_58(*local_meshes, i)).*);
            args.progress = *progress;
            task: Task = ---;
            task.user_data = cast(*void) ((cast(**Compute_Uv_Mesh_Charts_Task_Args) *(args)).*);
            task.func = internal_segment_run_compute_uv_mesh_charts_task;
            run(task_scheduler, task_group, task);
            i += 1;
        }
    }
    wait(task_scheduler, *task_group);
    return !operator_bool(*progress.cancel);
}

internal_segment_run_compute_uv_mesh_charts_task :: (unnamed_71388: *void, task_user_data: *void) {
    task: Compute_Uv_Mesh_Charts_Task = ---;
    defer deinit(*task);
    init(*task, cast(*Compute_Uv_Mesh_Charts_Task_Args) task_user_data);
    run(*task);
}

pack_charts :: (atlas: *Atlas, pack_options_: Pack_Options) {
    local_pack_options_: Pack_Options = pack_options_;
    if atlas == null {
        if s_print != null {
            s_print(c_string("PackCharts: atlas is null.\n"));
        }

        return;
    }
    ctx := cast(*Context) atlas;
    if is_empty(*ctx.meshes) && is_empty(*ctx.uv_mesh_instances) {
        if s_print != null {
            s_print(c_string("PackCharts: No meshes. Call AddMesh or AddUvMesh first.\n"));
        }

        return;
    }
    if is_empty(*ctx.uv_mesh_instances) {
        if !charts_computed(*ctx.param_atlas) {
            if s_print != null {
                s_print(c_string("PackCharts: ComputeCharts must be called first.\n"));
            }

            return;
        }
    } else if !ctx.uv_mesh_charts_computed {
        if s_print != null {
            s_print(c_string("PackCharts: ComputeCharts must be called first.\n"));
        }

        return;
    }
    if local_pack_options_.texels_per_unit < 0.0 {
        if s_print != null {
            s_print(c_string("PackCharts: PackOptions::texelsPerUnit is negative.\n"));
        }

        local_pack_options_.texels_per_unit = 0.0;
    }

    destroy_output_meshes(ctx);
    if atlas.utilization != null {
        internal_realloc(
            cast(*void) atlas.utilization,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            9577
        );
        atlas.utilization = cast(*float32) null;
    }
    if atlas.image != null {
        internal_realloc(
            cast(*void) atlas.image,
            0,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            9581
        );
        atlas.image = cast(*u32) null;
    }
    atlas.mesh_count = 0;

    pack_atlas: Pack_Atlas = ---;
    defer deinit(*pack_atlas);
    init(*pack_atlas);
    if !is_empty(*ctx.uv_mesh_instances) {
        {
            i_4: u32 = 0;
            while i_4 < size(*ctx.uv_mesh_instances) {
                add_uv_mesh_charts(
                    *pack_atlas,
                    (cast(**Uv_Mesh_Instance) index_explicit_17(*ctx.uv_mesh_instances, i_4)).*
                );
                i_4 += 1;
            }
        }
    } else {
        add_charts(*pack_atlas, ctx.task_scheduler, *ctx.param_atlas);
    }

    if !pack_charts(
        *pack_atlas,
        *local_pack_options_,
        cast,no_check(Progress_Func) (ctx.progress_func),
        ctx.progress_user_data
    ) {
        return;
    }

    atlas.atlas_count = get_num_atlases(*pack_atlas);
    atlas.chart_count = get_chart_count(*pack_atlas);
    atlas.width = get_width(*pack_atlas);
    atlas.height = get_height(*pack_atlas);
    atlas.texels_per_unit = get_texels_per_unit(*pack_atlas);
    if atlas.atlas_count > 0 {
        atlas.utilization =
            cast(*float32) internal_realloc(
                null,
                4 * cast(u64) atlas.atlas_count,
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                9606
            );
        {
            i_3: u32 = 0;
            while i_3 < atlas.atlas_count {
                atlas.utilization[i_3] = get_utilization(*pack_atlas, i_3);
                i_3 += 1;
            }
        }
    }
    if local_pack_options_.create_image {
        atlas.image =
            cast(*u32) internal_realloc(
                null,
                4 * cast(u64) (atlas.atlas_count * atlas.width * atlas.height),
                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                9611
            );
        {
            i_2: u32 = 0;
            while i_2 < atlas.atlas_count {
                copy_to(
                    (cast(**Atlas_Image) index_explicit_24(get_images(*pack_atlas), i_2)).*,
                    *atlas.image[atlas.width * atlas.height * i_2],
                    atlas.width,
                    atlas.height,
                    cast,no_check(s32) local_pack_options_.padding
                );
                i_2 += 1;
            }
        }
    }

    if s_print != null && s_print_verbose {
        s_print(c_string("Building output meshes\n"));
    }

    progress: s32 = 0;
    if ctx.progress_func != null {
        if !ctx.progress_func(PROGRESS_CATEGORY_BUILD_OUTPUT_MESHES, 0, ctx.progress_user_data) {
            return;
        }
    }
    if is_empty(*ctx.uv_mesh_instances) {
        atlas.mesh_count = size_2(*ctx.meshes);
    } else {
        atlas.mesh_count = size(*ctx.uv_mesh_instances);
    }
    atlas.meshes =
        cast(*Mesh) internal_realloc(
            null,
            40 * cast(u64) atlas.mesh_count,
            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
            9638
        );
    fill_memory(atlas.meshes, 0, 40 * cast(u64) atlas.mesh_count);
    if is_empty(*ctx.uv_mesh_instances) {
        chart_index_2: u32 = 0;
        {
            i: u32 = 0;
            while i < atlas.mesh_count {
                {
                    output_mesh_2 := *atlas.meshes[i];
                    mesh_polygon_mapping: *Mesh_Polygon_Mapping =
                        cast,no_check(*Mesh_Polygon_Mapping) ((cast(**Mesh_Polygon_Mapping) index_explicit_22(*ctx.mesh_polygon_mappings, i)).*);

                    polygon_touched: Bit_Array = ---;
                    defer deinit(*polygon_touched);
                    init(*polygon_touched);
                    if mesh_polygon_mapping != null {
                        resize(*polygon_touched, size(*mesh_polygon_mapping.face_vertex_count));
                        zero_out_memory(*polygon_touched);
                    }

                    invalid: *Invalid_Mesh_Geometry =
                        cast,no_check(*Invalid_Mesh_Geometry) invalid_mesh_geometry(
                            *ctx.param_atlas,
                            i
                        );
                    c_transpiler_compound_add(*(output_mesh_2.vertex_count), ((vertices(invalid)).length), u32, u32);
                    c_transpiler_compound_add(*(output_mesh_2.index_count), (((faces(invalid)).length * 3)), u32, u32);
                    {
                        cg_2: u32 = 0;
                        while cg_2 < chart_group_count(*ctx.param_atlas, i) {
                            chart_group_2: *Chart_Group =
                                cast,no_check(*Chart_Group) chart_group_at(*ctx.param_atlas, i, cg_2);
                            {
                                c__: u32 = 0;
                                while c__ < chart_count(chart_group_2) {
                                    chart_3 := chart_at(chart_group_2, c__);
                                    output_mesh_2.vertex_count += original_vertex_count(chart_3);
                                    FACE_COUNT_2 := face_count(unified_mesh(chart_3));
                                    if mesh_polygon_mapping != null {
                                        if 0 < FACE_COUNT_2 {
                                            for f_7: 0..FACE_COUNT_2 - 1 {
                                                POLYGON_3: u32 =
                                                    ((cast(**u32) *(index_explicit(
                                                        *mesh_polygon_mapping.triangle_to_polygon_map,
                                                        map_face_to_source_face(chart_3, f_7)
                                                    ))).*).*;
                                                if !get(*polygon_touched, POLYGON_3) {
                                                    set(*polygon_touched, POLYGON_3);
                                                    output_mesh_2.index_count +=
                                                        cast,no_check(u32) (((cast(**u8) *(index_explicit_23(
                                                            *mesh_polygon_mapping.face_vertex_count,
                                                            POLYGON_3
                                                        ))).*).*);
                                                }
                                            }
                                        }
                                    } else {
                                        output_mesh_2.index_count += FACE_COUNT_2 * 3;
                                    }
                                    output_mesh_2.chart_count += 1;
                                    c__ += 1;
                                }
                            }
                            cg_2 += 1;
                        }
                    }
                    output_mesh_2.vertex_array =
                        cast(*Vertex) internal_realloc(
                            null,
                            20 * cast(u64) output_mesh_2.vertex_count,
                            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                            9676
                        );
                    output_mesh_2.index_array =
                        cast(*u32) internal_realloc(
                            null,
                            4 * cast(u64) output_mesh_2.index_count,
                            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                            9677
                        );
                    output_mesh_2.chart_array =
                        cast(*Chart) internal_realloc(
                            null,
                            24 * cast(u64) output_mesh_2.chart_count,
                            cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                            c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                            9678
                        );
                    if s_print != null && s_print_verbose {
                        s_print(
                            c_string("   Mesh %u: %u vertices, %u triangles, %u charts\n"),
                            i,
                            output_mesh_2.vertex_count,
                            output_mesh_2.index_count / 3,
                            output_mesh_2.chart_count
                        );
                    }

                    first_vertex: u32 = 0;
                    {
                        mesh: *Invalid_Mesh_Geometry =
                            cast,no_check(*Invalid_Mesh_Geometry) invalid_mesh_geometry(
                                *ctx.param_atlas,
                                i
                            );
                        faces_2 := faces(mesh);
                        indices_2 := indices(mesh);
                        vertices_2 := vertices(mesh);

                        {
                            v_3: u32 = 0;
                            while v_3 < vertices_2.length {
                                vertex_3 := *output_mesh_2.vertex_array[v_3];
                                vertex_3.atlas_index = -1;
                                vertex_3.chart_index = -1;
                                vertex_3.uv[1] = 0.0;
                                vertex_3.uv[0] = vertex_3.uv[1];
                                vertex_3.xref = ((cast(**u32) *(index_explicit_12(*vertices_2, v_3))).*).*;
                                v_3 += 1;
                            }
                        }

                        {
                            f_6: u32 = 0;
                            while f_6 < faces_2.length {
                                INDEX_OFFSET_2: u32 = ((cast(**u32) *(index_explicit_12(*faces_2, f_6))).*).* * 3;
                                for j_2: 0..cast(u32) 3 - 1 {
                                    output_mesh_2.index_array[INDEX_OFFSET_2 + j_2] =
                                        ((cast(**u32) *(index_explicit_12(
                                            *indices_2,
                                            (f_6 * 3) + j_2
                                        ))).*).*;
                                }
                                f_6 += 1;
                            }
                        }
                        first_vertex = vertices_2.length;
                    }
                    mesh_chart_index: u32 = 0;
                    {
                        cg: u32 = 0;
                        while cg < chart_group_count(*ctx.param_atlas, i) {
                            chart_group: *Chart_Group =
                                cast,no_check(*Chart_Group) chart_group_at(*ctx.param_atlas, i, cg);
                            {
                                c_: u32 = 0;
                                while c_ < chart_count(chart_group) {
                                    chart_2 := chart_at(chart_group, c_);
                                    unified_mesh_3: *Internal_Mesh =
                                        cast,no_check(*Internal_Mesh) unified_mesh(chart_2);
                                    FACE_COUNT := face_count(unified_mesh_3);

                                    {
                                        v_2: u32 = 0;
                                        while v_2 < original_vertex_count(chart_2) {
                                            vertex_2 := *output_mesh_2.vertex_array[first_vertex + v_2];
                                            vertex_2.atlas_index = (get_chart(*pack_atlas, chart_index_2)).atlas_index;
                                            assert(vertex_2.atlas_index >= 0);
                                            vertex_2.chart_index = cast,no_check(s32) chart_index_2;
                                            uv: *Vector2 =
                                                cast,no_check(*Vector2) texcoord_2(
                                                    unified_mesh_3,
                                                    original_vertex_to_unified_vertex(
                                                    chart_2,
                                                    v_2
                                                )
                                                );
                                            (ifx true { assignment_101: float32 = cast,no_check(float32) (internal_max(
                                                (ifx true { temporary___g0: float32 = 0.0; *temporary___g0; }),
                                                *uv.x
                                            )); (vertex_2.uv[0]) = assignment_101; assignment_101; });
                                            (ifx true { assignment_102: float32 = cast,no_check(float32) (internal_max(
                                                (ifx true { temporary___g1: float32 = 0.0; *temporary___g1; }),
                                                *uv.y
                                            )); (vertex_2.uv[1]) = assignment_102; assignment_102; });
                                            vertex_2.xref = map_chart_vertex_to_source_vertex(chart_2, v_2);
                                            v_2 += 1;
                                        }
                                    }

                                    if 0 < FACE_COUNT {
                                        for f_5: 0..FACE_COUNT - 1 {
                                            INDEX_OFFSET := map_face_to_source_face(chart_2, f_5) * 3;
                                            for j: 0..cast(u32) 3 - 1 {
                                                out_index := INDEX_OFFSET + j;
                                                if mesh_polygon_mapping != null {
                                                    out_index =
                                                        ((cast(**u32) *(index_explicit(
                                                            *mesh_polygon_mapping.triangle_to_polygon_indices_map,
                                                            out_index
                                                        ))).*).*;
                                                }
                                                (ifx true { assignment_103: u32 = cast,no_check(u32) ((first_vertex + ((cast(**u32) *(index_explicit_12(
                                                    (ifx true { temporary___g2: Const_Array_View(u32) = original_vertices(chart_2); *temporary___g2; }),
                                                    (f_5 * 3) + j
                                                ))).*).*)); (output_mesh_2.index_array[out_index]) = assignment_103; assignment_103; });
                                            }
                                        }
                                    }

                                    output_chart_2 := *output_mesh_2.chart_array[mesh_chart_index];
                                    ATLAS_INDEX := (get_chart(*pack_atlas, chart_index_2)).atlas_index;
                                    assert(ATLAS_INDEX >= 0);
                                    output_chart_2.atlas_index = cast,no_check(u32) ATLAS_INDEX;
                                    output_chart_2.type =
                                        ifx is_invalid(chart_2) then CHART_TYPE_INVALID else type(chart_2);
                                    if mesh_polygon_mapping != null {
                                        zero_out_memory(*polygon_touched);
                                        output_chart_2.face_count = 0;
                                        if 0 < FACE_COUNT {
                                            for f_4: 0..FACE_COUNT - 1 {
                                                POLYGON_2: u32 =
                                                    ((cast(**u32) *(index_explicit(
                                                        *mesh_polygon_mapping.triangle_to_polygon_map,
                                                        map_face_to_source_face(chart_2, f_4)
                                                    ))).*).*;
                                                if !get(*polygon_touched, POLYGON_2) {
                                                    set(*polygon_touched, POLYGON_2);
                                                    output_chart_2.face_count += 1;
                                                }
                                            }
                                        }

                                        output_chart_2.face_array =
                                            cast(*u32) internal_realloc(
                                                null,
                                                4 * cast(u64) output_chart_2.face_count,
                                                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                                                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                                                9771
                                            );
                                        zero_out_memory(*polygon_touched);
                                        of: u32 = 0;
                                        if 0 < FACE_COUNT {
                                            for f_3: 0..FACE_COUNT - 1 {
                                                POLYGON: u32 =
                                                    ((cast(**u32) *(index_explicit(
                                                        *mesh_polygon_mapping.triangle_to_polygon_map,
                                                        map_face_to_source_face(chart_2, f_3)
                                                    ))).*).*;
                                                if !get(*polygon_touched, POLYGON) {
                                                    set(*polygon_touched, POLYGON);
                                                    output_chart_2.face_array[of] = POLYGON;
                                                    of += 1;
                                                }
                                            }
                                        }
                                    } else {
                                        output_chart_2.face_count = FACE_COUNT;
                                        output_chart_2.face_array =
                                            cast(*u32) internal_realloc(
                                                null,
                                                4 * cast(u64) output_chart_2.face_count,
                                                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                                                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                                                9783
                                            );
                                        {
                                            f_2: u32 = 0;
                                            while f_2 < output_chart_2.face_count {
                                                output_chart_2.face_array[f_2] = map_face_to_source_face(chart_2, f_2);
                                                f_2 += 1;
                                            }
                                        }
                                    }
                                    output_chart_2.material = 0;
                                    mesh_chart_index += 1;
                                    chart_index_2 += 1;
                                    first_vertex += original_vertex_count(chart_2);
                                    c_ += 1;
                                }
                            }
                            cg += 1;
                        }
                    }
                    assert(output_mesh_2.vertex_count == first_vertex);
                    assert(output_mesh_2.chart_count == mesh_chart_index);
                    if ctx.progress_func != null {
                        NEW_PROGRESS_2 :=
                            cast,no_check(s32) (((i + 1) / cast,no_check(float32) atlas.mesh_count) *
                                100.0);
                        if NEW_PROGRESS_2 != progress {
                            progress = NEW_PROGRESS_2;
                            if !ctx.progress_func(PROGRESS_CATEGORY_BUILD_OUTPUT_MESHES, progress, ctx.progress_user_data) {
                                return;
                            }
                        }
                    }
                }
                i += 1;
            }
        }
    } else {
        chart_index: u32 = 0;
        {
            m: u32 = 0;
            while m < size(*ctx.uv_mesh_instances) {
                output_mesh := *atlas.meshes[m];
                mesh_2 := (cast(**Uv_Mesh_Instance) index_explicit_17(*ctx.uv_mesh_instances, m)).*;

                output_mesh.vertex_count = size(*mesh_2.texcoords);
                output_mesh.index_count = size(*mesh_2.mesh.indices);
                output_mesh.chart_count = size(*mesh_2.mesh.charts);
                output_mesh.vertex_array =
                    cast(*Vertex) internal_realloc(
                        null,
                        20 * cast(u64) output_mesh.vertex_count,
                        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                        9813
                    );
                output_mesh.index_array =
                    cast(*u32) internal_realloc(
                        null,
                        4 * cast(u64) output_mesh.index_count,
                        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                        9814
                    );
                output_mesh.chart_array =
                    cast(*Chart) internal_realloc(
                        null,
                        24 * cast(u64) output_mesh.chart_count,
                        cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                        c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                        9815
                    );
                if s_print != null && s_print_verbose {
                    s_print(
                        c_string("   UV mesh %u: %u vertices, %u triangles, %u charts\n"),
                        m,
                        output_mesh.vertex_count,
                        output_mesh.index_count / 3,
                        output_mesh.chart_count
                    );
                }

                {
                    v: u32 = 0;
                    while v < size(*mesh_2.texcoords) {
                        vertex := *output_mesh.vertex_array[v];
                        vertex.uv[0] = (index_explicit_18(*mesh_2.texcoords, v)).x;
                        vertex.uv[1] = (index_explicit_18(*mesh_2.texcoords, v)).y;
                        vertex.xref = v;
                        MESH_CHART_INDEX: u32 =
                            ((cast(**u32) *(index_explicit(*mesh_2.mesh.vertex_to_chart_map, v))).*).*;
                        if MESH_CHART_INDEX == 4294967295 {
                            vertex.atlas_index = -1;
                            vertex.chart_index = -1;
                        } else {
                            chart_4: *Pack_Chart =
                                cast,no_check(*Pack_Chart) get_chart(*pack_atlas, chart_index +
                                    MESH_CHART_INDEX);
                            vertex.atlas_index = chart_4.atlas_index;
                            vertex.chart_index =
                                cast,no_check(s32) ((cast,no_check(u32) (cast,no_check(s32) chart_index)) +
                                    MESH_CHART_INDEX);
                        }
                        v += 1;
                    }
                }

                copy_memory(
                    output_mesh.index_array,
                    data(*mesh_2.mesh.indices),
                    (cast(u64) size(*mesh_2.mesh.indices)) * 4
                );

                {
                    c___: u32 = 0;
                    while c___ < size(*mesh_2.mesh.charts) {
                        output_chart := *output_mesh.chart_array[c___];
                        chart: *Pack_Chart = cast,no_check(*Pack_Chart) get_chart(*pack_atlas, chart_index);
                        assert(chart.atlas_index >= 0);
                        output_chart.atlas_index = cast,no_check(u32) chart.atlas_index;
                        output_chart.face_count = size(*chart.faces);
                        output_chart.face_array =
                            cast(*u32) internal_realloc(
                                null,
                                4 * cast(u64) output_chart.face_count,
                                cast(s32) INTERNAL_MEM_TAG_DEFAULT,
                                c_string("upstream/xatlas/source/xatlas/xatlas.cpp"),
                                9844
                            );
                        output_chart.material = chart.material;
                        {
                            f: u32 = 0;
                            while f < output_chart.face_count {
                                output_chart.face_array[f] = ((cast(**u32) *(index_explicit_7(*chart.faces, f))).*).*;
                                f += 1;
                            }
                        }
                        chart_index += 1;
                        c___ += 1;
                    }
                }
                if ctx.progress_func != null {
                    NEW_PROGRESS := cast,no_check(s32) (((m + 1) / cast,no_check(float32) atlas.mesh_count) * 100.0);
                    if NEW_PROGRESS != progress {
                        progress = NEW_PROGRESS;
                        if !ctx.progress_func(PROGRESS_CATEGORY_BUILD_OUTPUT_MESHES, progress, ctx.progress_user_data) {
                            return;
                        }
                    }
                }
                m += 1;
            }
        }
    }
    if ctx.progress_func != null && progress != 100 {
        ctx.progress_func(PROGRESS_CATEGORY_BUILD_OUTPUT_MESHES, 100, ctx.progress_user_data);
    }
}

generate :: (atlas: *Atlas, chart_options_: Chart_Options, pack_options_: Pack_Options) {
    if atlas == null {
        if s_print != null {
            s_print(c_string("Generate: atlas is null.\n"));
        }

        return;
    }
    ctx := cast(*Context) atlas;
    if is_empty(*ctx.meshes) && is_empty(*ctx.uv_mesh_instances) {
        if s_print != null {
            s_print(c_string("Generate: No meshes. Call AddMesh or AddUvMesh first.\n"));
        }

        return;
    }
    compute_charts(atlas, chart_options_);
    pack_charts(atlas, pack_options_);
}

set_progress_callback :: (atlas: *Atlas, progress_func: Progress_Func, progress_user_data: *void) {
    if atlas == null {
        if s_print != null {
            s_print(c_string("SetProgressCallback: atlas is null.\n"));
        }

        return;
    }
    ctx := cast(*Context) atlas;
    ctx.progress_func = progress_func;
    ctx.progress_user_data = progress_user_data;
}

set_alloc :: (realloc_func: Realloc_Func, free_func: Free_Func) {
    s_realloc = realloc_func;
    s_free = free_func;
}

set_print :: (print: Print_Func, verbose: bool) {
    s_print = print;
    s_print_verbose = verbose;
}

string_for_enum :: (error: Add_Mesh_Error) -> *s8 {
    if error == ADD_MESH_ERROR_ERROR {
        return c_string("Unspecified error");
    }
    if error == ADD_MESH_ERROR_INDEX_OUT_OF_RANGE {
        return c_string("Index out of range");
    }
    if error == ADD_MESH_ERROR_INVALID_FACE_VERTEX_COUNT {
        return c_string("Invalid face vertex count");
    }
    if error == ADD_MESH_ERROR_INVALID_INDEX_COUNT {
        return c_string("Invalid index count");
    }
    return c_string("Success");
}

string_for_enum_2 :: (category: Progress_Category) -> *s8 {
    if category == PROGRESS_CATEGORY_ADD_MESH {
        return c_string("Adding mesh(es)");
    }
    if category == PROGRESS_CATEGORY_COMPUTE_CHARTS {
        return c_string("Computing charts");
    }
    if category == PROGRESS_CATEGORY_PACK_CHARTS {
        return c_string("Packing charts");
    }
    if category == PROGRESS_CATEGORY_BUILD_OUTPUT_MESHES {
        return c_string("Building output meshes");
    }
    return c_string("");
}

globals_initialization_state_for_xatlas: u32;
initialize_globals_for_xatlas :: () {
    state := atomic_load(*globals_initialization_state_for_xatlas);
    if state == 2 return;
    won, _ := compare_and_swap(*globals_initialization_state_for_xatlas, 0, 1);
    if !won {
        while atomic_load(*globals_initialization_state_for_xatlas) != 2 {}
        return;
    }
    K_IMAGE_CHART_INDEX_MASK = 0x1fffffff;
    K_IMAGE_HAS_CHART_INDEX_BIT = 0x80000000;
    K_IMAGE_IS_BILINEAR_BIT = 0x40000000;
    K_IMAGE_IS_PADDING_BIT = 0x20000000;
    s_realloc = cast,no_check(Realloc_Func) c_transpiler_realloc;
    s_free = cast,no_check(Free_Func) c_transpiler_free;
    s_print = cast,no_check(Print_Func) c_transpiler_printf;
    s_print_verbose = false;
    K_PI = cast(float32) 3.14159265358979323846;
    K_PI2 = cast(float32) 6.28318530717958647692;
    K_EPSILON = 0.0001;
    K_AREA_EPSILON = cast(float32) 1.19209290e-7;
    K_NORMAL_EPSILON = 0.001;
    INTERNAL_MESH_FACE_GROUPS_K_INVALID = 4294967295;
    atomic_store(*globals_initialization_state_for_xatlas, 2);
}

floorf :: (x: float32) -> float32 #foreign C_Transpiler_LibM;

Cpp_Transpiler_LibStdCpp :: #library,system "libstdc++.so.6";
_ZSt21__glibcxx_assert_failPKciS0_S0_ :: (
    file: *s8,
    line: s32,
    function: *s8,
    condition: *s8
) #foreign Cpp_Transpiler_LibStdCpp;
std_glibcxx_assert_fail :: _ZSt21__glibcxx_assert_failPKciS0_S0_;

atan2f :: (y: float32, x: float32) -> float32 #foreign C_Transpiler_LibM;

cosf :: (x: float32) -> float32 #foreign C_Transpiler_LibM;

sinf :: (x: float32) -> float32 #foreign C_Transpiler_LibM;

qsort :: (base: *void, nmemb: u64, size_3: u64, compar: compar_fn_t) #foreign C_Transpiler_LibC;

acosf :: (x: float32) -> float32 #foreign C_Transpiler_LibM;

Atlas :: struct {
    image: *u32;
    meshes: *Mesh;
    utilization: *float32;
    width: u32;
    height: u32;
    atlas_count: u32;
    chart_count: u32;
    mesh_count: u32;
    texels_per_unit: float32;
}

Progress_Func :: #type (_: Progress_Category, _: s32, _: *void) -> bool;

struct_atomic_Bool :: struct {
    base: struct_atomic_base_Bool #align 1;
} #no_padding;

Progress_Category :: s32;
PROGRESS_CATEGORY_ADD_MESH : Progress_Category : 0;
PROGRESS_CATEGORY_COMPUTE_CHARTS : Progress_Category : 1;
PROGRESS_CATEGORY_PACK_CHARTS : Progress_Category : 2;
PROGRESS_CATEGORY_BUILD_OUTPUT_MESHES : Progress_Category : 3;

struct_atomic_unsigned_int :: struct {
    layout_padding_0: [4] u8 #align 1;
    alignment_marker_1: [0] u8 #align 4;
} #no_padding;

Uv_Mesh_Decl :: struct {
    vertex_uv_data: *void;
    index_data: *void;
    face_material_data: *u32;
    vertex_count: u32;
    vertex_stride: u32;
    index_count: u32;
    index_offset: s32;
    index_format: Index_Format;
}

Chart_Type :: s32;
CHART_TYPE_PLANAR : Chart_Type : 0;
CHART_TYPE_ORTHO : Chart_Type : 1;
CHART_TYPE_LSCM : Chart_Type : 2;
CHART_TYPE_PIECEWISE : Chart_Type : 3;
CHART_TYPE_INVALID : Chart_Type : 4;

Chart_Options :: struct {
    param_func: Parameterize_Func;
    max_chart_area: float32;
    max_boundary_length: float32;
    normal_deviation_weight: float32;
    roundness_weight: float32;
    straightness_weight: float32;
    normal_seam_weight: float32;
    texture_seam_weight: float32;
    max_cost: float32;
    max_iterations: u32;
    use_input_mesh_uvs: bool;
    fix_winding: bool;
}

atomic_flag :: struct {
    layout_padding_0: [1] u8 #align 1;
} #no_padding;

Realloc_Func :: #type (_: *void, _: u64) -> *void;

Free_Func :: #type (_: *void);

Print_Func :: #type (_: *s8, variadic_arguments: ..Any) -> s32;

Pack_Options :: struct {
    max_chart_size: u32;
    padding: u32;
    texels_per_unit: float32;
    resolution: u32;
    bilinear: bool;
    block_align: bool;
    brute_force: bool;
    create_image: bool;
    rotate_charts_to_axis: bool;
    rotate_charts: bool;
}

struct_atomic_base_Bool :: struct {
    i: std_atomic_base_bool_int_type #align 1;
} #no_padding;

std_memory_order :: s32;
STD_MEMORY_ORDER_RELAXED : std_memory_order : 0;
STD_MEMORY_ORDER_CONSUME : std_memory_order : 1;
STD_MEMORY_ORDER_ACQUIRE : std_memory_order : 2;
STD_MEMORY_ORDER_RELEASE : std_memory_order : 3;
STD_MEMORY_ORDER_ACQ_REL : std_memory_order : 4;
STD_MEMORY_ORDER_SEQ_CST : std_memory_order : 5;

std_atomic_base_bool_int_type :: bool;

std_memory_order_modifier :: u32;
STD_MEMORY_ORDER_MASK : std_memory_order_modifier : 65535;
STD_MEMORY_ORDER_MODIFIER_MASK : std_memory_order_modifier : 4294901760;
STD_MEMORY_ORDER_HLE_ACQUIRE : std_memory_order_modifier : 65536;
STD_MEMORY_ORDER_HLE_RELEASE : std_memory_order_modifier : 131072;

struct_atomic_base_unsigned_int :: struct {
    i: std_atomic_base_unsigned_int_int_type #align 4;
} #no_padding;

std_atomic_base_unsigned_int_int_type :: u32;

Parameterize_Func :: #type (_: *float32, _: *float32, _: u32, _: *u32, _: u32);

compar_fn_t :: #type (_: *void, _: *void) -> s32;

Mesh_Decl :: struct {
    vertex_position_data: *void;
    vertex_normal_data: *void;
    vertex_uv_data: *void;
    index_data: *void;
    face_ignore_data: *bool;
    face_material_data: *u32;
    face_vertex_count: *u8;
    vertex_count: u32;
    vertex_position_stride: u32;
    vertex_normal_stride: u32;
    vertex_uv_stride: u32;
    index_count: u32;
    index_offset: s32;
    face_count: u32;
    index_format: Index_Format;
    epsilon: float32;
}

atomic_flag_base :: struct {
    i: atomic_flag_data_type;
}

Index_Format :: s32;
INDEX_FORMAT_U_INT16 : Index_Format : 0;
INDEX_FORMAT_U_INT32 : Index_Format : 1;

std_atomic_unsigned_int_integral_type :: u32;

Mesh :: struct {
    chart_array: *Chart;
    index_array: *u32;
    vertex_array: *Vertex;
    chart_count: u32;
    index_count: u32;
    vertex_count: u32;
}

Chart :: struct {
    face_array: *u32;
    atlas_index: u32;
    face_count: u32;
    type: Chart_Type;
    material: u32;
}

Vertex :: struct {
    atlas_index: s32;
    chart_index: s32;
    uv: [2] float32;
    xref: u32;
}

Add_Mesh_Error :: s32;
ADD_MESH_ERROR_SUCCESS : Add_Mesh_Error : 0;
ADD_MESH_ERROR_ERROR : Add_Mesh_Error : 1;
ADD_MESH_ERROR_INDEX_OUT_OF_RANGE : Add_Mesh_Error : 2;
ADD_MESH_ERROR_INVALID_FACE_VERTEX_COUNT : Add_Mesh_Error : 3;
ADD_MESH_ERROR_INVALID_INDEX_COUNT : Add_Mesh_Error : 4;

atomic_flag_data_type :: bool;


program_initialization_state: u32;
program_initialization_owner: u32;
initialize_program :: () {
    state := atomic_load(*program_initialization_state);
    if state == 2 return;
    thread_id := cast(u32) thread_local_index() + 1;
    if state == 1 {
        if atomic_load(*program_initialization_owner) == thread_id return;
        while atomic_load(*program_initialization_state) != 2 {}
        return;
    }
    won, _ := compare_and_swap(*program_initialization_state, 0, 1);
    if !won {
        while atomic_load(*program_initialization_state) != 2 {}
        return;
    }
    atomic_store(*program_initialization_owner, thread_id);
    initialize_globals_for_xatlas();
    atomic_store(*program_initialization_owner, 0);
    atomic_store(*program_initialization_state, 2);
}
