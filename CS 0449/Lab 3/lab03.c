#include <stdio.h>
#include <stdlib.h>

struct Node{
    int grade;
    struct Node *next;
} Node;

int main(){
    struct Node *head = malloc(sizeof(struct Node));
    struct Node *node_a = head;
    int input;
    int no_of_Entries;
    int avg;
    int sum = 0;
    
    while(input != -1){
        scanf("Enter Grade: %d \n", &input);
        
        if(input == -1){
            break;
        }
        node_a -> grade = input;
        node_a -> next = malloc(sizeof(Node));
        node_a = node_a -> next;
    }
    
    struct Node *temp = head;
    
    while(temp != NULL){
        sum += temp -> grade;
        temp = temp -> next;
        no_of_Entries++;
    }
    
    no_of_Entries = no_of_Entries - 1;
    avg = sum / no_of_Entries;
    printf(" The avgerage is %d \n", avg);
    
    struct Node* temp2;
    
    while (head != NULL){
        temp2 = head;
        head = head -> next;
        free(temp2);
    }
    return 0;
}
