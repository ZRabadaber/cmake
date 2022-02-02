
#include "components.h"
#include "core_components.h"

#ifndef CORE_COMPONENTS
#define CORE_COMPONENTS 0
#endif

static component_t *components[] = {
		CORE_COMPONENTS,
		0
};

#define COMPONENTS_FOREACH_CALL(c) \
  for(component_t **__m = components; *__m; __m++) \
    if ((*__m)->c) (*__m)->c();

#define COMPONENTS_FOREACH_CALL_ARG(c, a) \
  for(component_t **__m = components; *__m; __m++) \
    if ((*__m)->c) (*__m)->c(a);
