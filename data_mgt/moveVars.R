
# `moveVars()` moves variable(s) in a dataframe either to the left or right (in-between); or make them the first or last columns (end-point). 

# Inputs:

# `df` - is the input dataset
# `move_vars` - a vector of variables to move
# `rightof` -  variable to which the moved variable(s) will be to it's right
# `leftof` - variable to which the moved variable(s) will be to it's left
# `ends` - moves the variable(s) left most `(ends = "first")` or right most `(ends = "last")`

# Details:

# If `rightof` and `leftof` are not specified, the function will try to use `ends` to move the variables. However, if all the `*_of` and `ends` are specified, by default the function will perform in-between movement. 

# Value:

# Dataframe with shilfted varibales.

moveVars <- function(df, move_vars, rightof = NULL, leftof = NULL, ends = c("first", "last")){
  
  varnames <- colnames(df)
  temp_varnames <- setdiff(varnames, move_vars)
  
  if (missing(rightof) & missing(leftof) & !missing(ends)){
    if (sum(c("first", "last") %in% ends) == 0){
      stop("ends can only be either 'first' or 'last'")
    }
    if (sum("first" %in% ends) > 0){
      new_order <- c(move_vars, temp_varnames)
    }
    if (sum("last" %in% ends) > 0){
      new_order <- c(temp_varnames, move_vars)
    }
    df <- (df
      %>% select(new_order)
    )
    return(df)
  }
  
  else{
    if(is.null(rightof) & is.null(leftof) & missing(ends)){
      stop("You can not organise variables without specifying where to move them.")
    }
    
    if (!rightof %in% varnames){
      stop("Specified rightof variable not in the dataset")
    }
    
    if (!leftof %in% varnames){
      stop("Specified leftof variable not in the dataset")
    }
    if (sum(rightof %in% move_vars) > 0 | sum(leftof %in% move_vars) > 0){
      stop("You cannot move a variable within itself.")
    }
    
    if (is.null(rightof) & !is.null(leftof)){
      stop("Specify rightof variable")
    }
    
    if (!is.null(rightof) & is.null(leftof)){
      stop("Specify leftof variable")
    }
    
    if(!is.null(rightof) & !is.null(leftof)){
      left_indices <- c(match(first(temp_varnames), temp_varnames):match(rightof, temp_varnames))
      left_vars <- temp_varnames[left_indices]
      right_vars <- setdiff(temp_varnames, left_vars)
      right_vars <- c(leftof, setdiff(right_vars, leftof))
      new_order <- c(left_vars, move_vars, right_vars)
    }
    df <- (df
      %>% select(new_order)
    )
    return(df)
  }
}

