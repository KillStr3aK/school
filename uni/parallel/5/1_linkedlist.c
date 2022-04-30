/*
            2022
    Parhuzamos Algoritmusok
      Ivacs David, OYFTRQ
*/

#include <stdio.h>
#include <stdlib.h>

/*
    Láncolt lista implementálás
        nem thread safe
*/

typedef struct
{
    int Data;
    struct ListNode* Next;
} ListNode;

typedef struct
{
    ListNode* Head;
} LinkedList;

ListNode* ListNode_Create(int);

LinkedList* LinkedList_Create();
void LinkedList_Add(LinkedList*, int);
void LinkedList_Delete(LinkedList*, int);
void LinkedList_Display(LinkedList*);
void LinkedList_Reverse(LinkedList*);
void LinkedList_Dispose(LinkedList*);

ListNode* ListNode_Create(int data)
{
    ListNode* node = malloc(sizeof(ListNode));
    if(node == NULL)
        return node;

    node->Data = data;
    node->Next = NULL;
    return node;
}

LinkedList* LinkedList_Create()
{
    LinkedList* list = malloc(sizeof(LinkedList));
    if(list == NULL)
        return list;

    list->Head = NULL;
    return list;
}

void LinkedList_Display(LinkedList* list)
{
    if(list->Head == NULL)
        return;

    ListNode* current = list->Head;
    for(; current != NULL; current = current->Next)
    {
        printf("%d\n", current->Data);
    }
}

void LinkedList_Add(LinkedList* list, int data)
{
    if(list->Head == NULL)
    {
        list->Head = ListNode_Create(data);
    } else {
        ListNode* current = NULL;
        while(current->Next != NULL)
        {
            current = current->Next;
        }

        current->Next = ListNode_Create(data);
    }
}

void LinkedList_Delete(LinkedList* list, int data)
{
    ListNode* current = list->Head;
    ListNode* previous = current;

    while(current != NULL)
    {
        if(current->Data == data)
        {
            previous->Next = current->Next;

            if(current == list->Head)
                list->Head = current->Next;

            free(current);
            return;
        }

        previous = current;
        current = current->Next;
    }
}

void LinkedList_Reverse(LinkedList* list)
{
    ListNode* reversed = NULL;
    ListNode* current = list->Head;
    ListNode* temp = NULL;

    while(current != NULL)
    {
        temp = current;
        current = current->Next;
        temp->Next = reversed;
        reversed = temp;
    }

    list->Head = reversed;
}

void LinkedList_Dispose(LinkedList* list)
{
    ListNode* current = list->Head;
    ListNode* next = current;

    while(current != NULL)
    {
        next = current->Next;
        free(current);
        current = next;
    }
}
