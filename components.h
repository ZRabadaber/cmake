//
// Created by zraba on 31.01.2022.
//

#ifndef CORE_SRC_COMPONENTS_H_
#define CORE_SRC_COMPONENTS_H_

typedef struct {
	int (*define)(void);
	int (*init)(void);
	void (*run)(void);
} component_t;

#endif //CORE_SRC_COMPONENTS_H_
