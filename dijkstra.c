/*
   Solution for Code Jame Problem Dijkstra
   url: http://code.google.com/codejam/contest/6224486/dashboard#s=p2
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX 10001

char quart[100][100];

int ** build_matrix(int N, int M){
  int **c;
  int i = 0;
  /* N is the number of rows  */
  /* note: c is char** */
  if (( c = malloc( N*sizeof( int* ))) == NULL )
  { 
    return NULL;
    /* error */ 
  }

  for ( i = 0; i < N; i++ )
  {
    /* x_i here is the size of given row, no need to
     * multiply by sizeof( char ), it's always 1
     */
    if (( c[i] = malloc( M * sizeof(int) )) == NULL )
    { /* error */ 
      return NULL;
    }

    /* probably init the row here */
  }
  return c;
}

void free_matrix(int **matrix, int N, int M){
  int i;
  for(i = 0; i < N; i++){
    free(matrix[i]);
  }
  free(matrix);
}

void zero_matrix(int **matrix, int N, int M){
  int i =0, j;
  for( i =0 ; i<N; i++){
//    memset(matrix[i], 0, sizeof(matrix[i][0]) * M);
    for( j =0 ; j<M; j++){
      matrix[i][j] = 0;
    }
  }
}



int sub_mult(char *arr, int **matrix, int i, int j, int stride){
  if( matrix[i][j] != 0){
    return matrix[i][j];
  }
  if( i == j ){
    int index = i % stride;
   // printf("arr[%d] stride: %d i: %d\n", index, stride, i);
    return arr[index];
  } 
  int mid = (j-i)/2;
  int part1 = sub_mult(arr, matrix, i, i+mid, stride);
  int part2 = sub_mult(arr, matrix, i+mid+1, j, stride);
  //matrix[i][j] = part1 * part2;
  //printf("quart[%d][%d]\n", part1, part2);
  int negative1 = 0;
  int negative2 = 0;
  if( part1 < 0 ) {
    part1 *= -1;
    negative1 = 1;
  }
  if( part2 < 0 ) {
    part2 *= -1;
    negative2 = 1;
  }
  matrix[i][j] = quart[part1][part2];
  if ( (negative1 && !negative2) || (!negative1 && negative2) ){
    matrix[i][j] *= -1;
  }
  return matrix[i][j];
}

int find(char *arr, int **matrix, int size, int stride){
  //printf("PASSOU AKI");
  //FIND I
  int i, k;
  for(i = 0; i < size; i++){
    //printf("testing I in %d~%d\n", 0, i);
    if( sub_mult(arr, matrix, 0, i, stride) == 'i'){
      for(k = size-1; k >= i+2; k--){
     //   printf("testing K in %d~%d\n", k, size-1);
        if( sub_mult(arr, matrix, k, size-1, stride) == 'k'){
      //    printf("testing J in %d~%d\n", i+1, k-1);
          if( sub_mult(arr, matrix, i+1, k-1, stride) == 'j'){
            return 1;
          }
        }
      }
    }
  }
  return 0;
}

void print_quart(){

  printf("quart[1][1]: %c\n", quart['1']['1'] < 0 ?  quart['1']['1'] *-1 : quart['1']['1'] );
  printf("quart[1][i]: %c\n", quart['1']['i'] < 0 ?  quart['1']['i'] *-1 : quart['1']['i'] );
  printf("quart[1][j]: %c\n", quart['1']['j'] < 0 ?  quart['1']['j'] *-1 : quart['1']['j'] );
  printf("quart[1][k]: %c\n", quart['1']['k'] < 0 ?  quart['1']['k'] *-1 : quart['1']['k'] );
                                                                                           
  printf("quart[i][1]: %c\n", quart['i']['1'] < 0 ?  quart['i']['1'] *-1 : quart['i']['1'] );
  printf("quart[i][i]: %c\n", quart['i']['i'] < 0 ?  quart['i']['i'] *-1 : quart['i']['i'] );
  printf("quart[i][j]: %c\n", quart['i']['j'] < 0 ?  quart['i']['j'] *-1 : quart['i']['j'] );
  printf("quart[i][k]: %c\n", quart['i']['k'] < 0 ?  quart['i']['k'] *-1 : quart['i']['k'] );
                                                                                           
  printf("quart[j][1]: %c\n", quart['j']['1'] < 0 ?  quart['j']['1'] *-1 : quart['j']['1'] );
  printf("quart[j][i]: %c\n", quart['j']['i'] < 0 ?  quart['j']['i'] *-1 : quart['j']['i'] );
  printf("quart[j][j]: %c\n", quart['j']['j'] < 0 ?  quart['j']['j'] *-1 : quart['j']['j'] );
  printf("quart[j][k]: %c\n", quart['j']['k'] < 0 ?  quart['j']['k'] *-1 : quart['j']['k'] );
                                                                                           
  printf("quart[k][1]: %c\n", quart['k']['1'] < 0 ?  quart['k']['1'] *-1 : quart['k']['1'] );
  printf("quart[k][i]: %c\n", quart['k']['i'] < 0 ?  quart['k']['i'] *-1 : quart['k']['i'] );
  printf("quart[k][j]: %c\n", quart['k']['j'] < 0 ?  quart['k']['j'] *-1 : quart['k']['j'] );
  printf("quart[k][k]: %c\n", quart['k']['k'] < 0 ?  quart['k']['k'] *-1 : quart['k']['k'] );
}

int main (){

  quart['1']['1'] = '1';
  quart['1']['i'] = 'i';
  quart['1']['j'] = 'j';
  quart['1']['k'] = 'k';

  quart['i']['1'] = 'i';
  quart['i']['i'] = '1' * -1;
  quart['i']['j'] = 'k';
  quart['i']['k'] = 'j' * -1;

  quart['j']['1'] = 'j';
  quart['j']['i'] = 'k' * -1;
  quart['j']['j'] = '1' * -1;
  quart['j']['k'] = 'i';

  quart['k']['1'] = 'k';
  quart['k']['i'] = 'j';
  quart['k']['j'] = 'i' * -1;
  quart['k']['k'] = '1' * -1;

  //print_quart();

  //printf("%d\n", quart['i']['1']);

  int T;
  int L, X;
  int i = 0;
  char *ijk = (char*) malloc(sizeof(char) * (10001));
  int **matrix = build_matrix(MAX,MAX);
  if( matrix == NULL ) {
    printf("Out of memory\n");
    return -1;
  }
  if( ijk == NULL ) {
    printf("Out of memory\n");
    return -1;
  }
  scanf("%d", &T);

  for(i = 0; i < T; i++){
   // printf("AKI 1\n");
  //  printf("AKI 3\n");
    scanf("%d %d", &L, &X);
 //   printf("AKI 5\n");
    //printf("L: %d\n", L);
    int size = L * X;
//    int matrix[size][size];
    scanf("%s\n", ijk);
//    printf("AKI 10\n");
    zero_matrix(matrix, size, size);
    if( find(ijk, matrix, size, L)){
      printf("Case #%d: YES\n", i+1);
    }else{
      printf("Case #%d: NO\n", i+1);
    }
    //printf("%s\n", ijk);

  }
  free(ijk);
  free_matrix(matrix, MAX, MAX);

  return 0;
}
