#include <array>
using namespace Rcpp;

typedef std::array<int, 2> id_array; 
typedef std::pair<std::vector<int>, double> edge_value;
typedef std::map<id_array, edge_value> edge_map;

/**
 * Finds all possible edges from a set of cascades
 * 
 * @param cascade_nodes A list of integer vectors containing the nodes involved 
 *     in each cascade in order of infection
 * @param cascade_times A list of numeric vectors containing the infection times
 *     of each node in the corresponding vector in cascade_nodes
 * @param quiet Should progress be reported
 * 
 * @return edge_map with all possible edges
 */
edge_map get_possible_edges_(List &cascade_nodes, List &cascade_times,
                             bool &quiet);

/**
 * Wrapper to count possible edges (for rcpp export)
 * @param cascade_nodes A list of integer vectors containing the nodes involved 
 *     in each cascade in order of infection
 * @param cascade_times A list of numeric vectors containing the infection times
 *     of each node in the corresponding vector in cascade_nodes
 * @param quiet Should progress be reported
 *     
 * @return integer number of possible edges
 */
int count_possible_edges_(List &cascade_nodes, List &cascade_times, 
                          bool &quiet);
