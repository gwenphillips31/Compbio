### looking at some glms from a bee dataset
#g. phillips
#########################################################

library(tidyverse)
library(lubridate)
library(lme4)
library(car)

bee_dat <- read.csv("data/Burnham_field_data_pathogens_wide.csv")

### renaming vars
bee_dat <- bee_dat %>%
  mutate(
    sampling_date = mdy(sampling_date),
    site_code = factor(site_code),
    field_id = factor(field_id),
    bee_caste = factor(bee_caste),
    bombus_spp = factor(bombus_spp),
    host_plant = factor(host_plant),
    sampling_event = factor(sampling_event),
    sampling_event_num = as.numeric(as.character(sampling_event)),
    log10_BQCV_load = log10(BQCV_pathogen_load + 1),
    log10_DWV_load = log10(DWV_pathogen_load + 1),
    log10_Nosema_load = log10(Nosema_pathogen_load + 1)
  )

glimpse(bee_dat)


# filter for only pos:
df_filtered <- bee_dat[bee_dat$log10_DWV_load > 0 & bee_dat$log10_BQCV_load > 0, ]

qplot(
  x = log10_BQCV_load,
  y = log10_DWV_load,
  data = df_filtered) +
geom_smooth(method = "lm", se = TRUE)

m_cont_cont <- lm(log10_DWV_load ~ log10_BQCV_load, data = df_filtered)
Anova(m_cont_cont)

qplot(
  x = bombus_spp,
  y = log10_BQCV_load,
  data = df_filtered,
  geom = "boxplot")

m_cont_cat <- lm(log10_BQCV_load ~ bombus_spp, data = df_filtered)
Anova(m_cont_cat)

qplot(
  x = log10_BQCV_load,
  y = DWV_pathogen_binary,
  data = bee_dat) +
  geom_smooth(
    method = "glm",
    method.args = list(family = "binomial"))

m_cat_cont <- glm(
  DWV_pathogen_binary ~ log10_BQCV_load,
  data = bee_dat,
  family = binomial(link="logit")
)
Anova(m_cat_cont)

# summarize
sm <- bee_dat %>% 
  group_by(bee_caste) %>%
  dplyr::summarise(
    mean = mean(DWV_pathogen_binary, na.rm=T), 
  ) 

qplot(
  x = bee_caste,
  y = mean,
  data = sm
)

m_cat_cat <- glm(
  DWV_pathogen_binary ~ bee_caste,
  data = bee_dat,
  family = binomial(link="logit")
)
summary(m_cat_cat)

# a model using a binomial dist.
bin_mod <- glm(data = bee_dat, DWV_pathogen_binary ~ bombus_spp * sampling_event 
  + host_plant, family = binomial(link="logit"))

# a gaussian model:
gaus_mod <- lm(data = bee_dat, log10_Nosema_load ~ sampling_event * host_plant)

summary(bin_mod)

summary(gaus_mod)

Anova(bin_mod, type = 2)
Anova(gaus_mod, type = 2)

m_dwv_null <- lm(data = df_filtered, log10_DWV_load ~ 1)
m_dwv_full <- lm(data = df_filtered, log10_DWV_load ~ sampling_event + host_plant)

anova(m_dwv_null, m_dwv_full, test = "LRT")

m_dwv_reduced <- lm(data = df_filtered, log10_DWV_load ~ sampling_event)

anova(m_dwv_reduced, m_dwv_full, test = "LRT")

drop1(m_dwv_full, test = "Chisq")
qplot(
  x = factor(BQCV_pathogen_binary),
  data = bee_dat,
  geom = "bar")

qplot(
  x = DWV_pathogen_load,
  data = df_filtered,
  geom = "histogram",
  bins = 30)

qplot(
  x = log10_DWV_load,
  data = df_filtered,
  geom = "histogram",
  bins = 30)

qplot(
  x = Nosema_pathogen_load,
  data = bee_dat,
  geom = "histogram",
  bins = 30)

m_dwv_log <- lm(log10_DWV_load ~ sampling_event + bee_caste, data = bee_dat)
summary(m_dwv_log)

g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + sampling_event + (1 | site_code),
  data = df_filtered)

Anova(g_bqcv_site)

g_bqcv_site <- lmer(
  log10_BQCV_load ~ bombus_spp + (1 | site_code/sampling_event),
  data = df_filtered)

Anova(g_bqcv_site)

# make pos only nosema
nosPos <- bee_dat[bee_dat$Nosema_pathogen_load > 0,]

# gamma
nos_gamma <- glmer(
  Nosema_pathogen_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos, family = Gamma)
Anova(nos_gamma)
# log
nos_log <- lmer(
  log10_Nosema_load ~ site_code + bombus_spp + (1 | sampling_event),
  data = nosPos)
Anova(nos_log)

qplot(
  x = sampling_event_num,
  y = log10_DWV_load,
  color = bee_caste,
  data = bee_dat)

m_dwv_interaction <- lmer(log10_DWV_load ~ sampling_event * bee_caste + 
  (1 | site_code), data = bee_dat)
summary(m_dwv_interaction)
Anova(m_dwv_interaction, type = 2)

m_bqcv_interaction <- glm(
  BQCV_pathogen_binary ~ sampling_event * log10_DWV_load,
  data = bee_dat,
  family = binomial(link="logit")
)
summary(m_bqcv_interaction)

Anova(m_bqcv_interaction, type = 2)

m_bqcv_additive <- glm(
  BQCV_pathogen_binary ~ sampling_event + log10_DWV_load,
  data = bee_dat,
  family = binomial(link="logit")
)

summary(m_bqcv_additive) # higher aic

Anova(m_bqcv_additive, type = 2)
anova(m_bqcv_additive, m_bqcv_interaction, test = "Chisq")
