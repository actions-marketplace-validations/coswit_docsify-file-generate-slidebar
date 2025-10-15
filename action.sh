#!/bin/bash

indent=0
root_dir="$1"

function print_indent() {
    printf "%*s" $((indent * 2)) ""
}

function has_matching_files() {
    local dir_path="$1"
    local include="$2"
    local is_root="${3:-0}"
    
    # 检查当前目录下是否有匹配的文件
    for file in "$dir_path"/*; do
        [[ ! -f "$file" ]] && continue
        local filename=$(basename "$file")
        [[ "$filename" =~ $include ]] && return 0
    done
    
    # 检查子目录是否包含匹配文件
    for file in "$dir_path"/*; do
        [[ ! -d "$file" ]] && continue
        has_matching_files "$file" "$include" 0 && return 0
    done
    
    return 1
}

function read_dir() {
    local dir_path="$1"
    local include="$2"
    local is_root="${3:-0}"  # 标记是否为根目录
    
    # 检查目录是否存在
    [[ ! -d "$dir_path" ]] && return
    
    # 检查当前目录或其子目录是否有匹配文件
    if ! has_matching_files "$dir_path" "$include" $is_root; then
        return  # 如果不匹配，直接返回，不显示此目录
    fi
    
    # 如果是根目录或目录包含匹配文件，显示目录名
    if [[ $is_root -eq 1 ]] || has_matching_files "$dir_path" "$include" $is_root; then
        if [[ $is_root -eq 0 ]]; then
            print_indent
            echo "- $(basename "$dir_path")"
        fi
        
        # 增加缩进并处理内容
        ((indent++))
        
        # 先处理文件
        for file in "$dir_path"/*; do
            [[ ! -f "$file" ]] && continue
            
            local filename=$(basename "$file")
            # 如果是根目录，跳过_sidebar.md文件
            if [[ $is_root -eq 1 ]] && ([[ "$filename" == "_sidebar.md" ]] || [[ "$filename" == "README.md" ]]); then
                continue
            fi
            
            if [[ $filename =~ $include ]]; then
                print_indent
                local encoded_path=$(echo "$file" | sed 's/ /%20/g')
                echo "- [$filename]($encoded_path)"
            fi
        done
        
        # 再处理子目录
        for file in "$dir_path"/*; do
            [[ ! -d "$file" ]] && continue
            read_dir "$file" "$include" 0
        done
        
        ((indent--))
    fi
}

# 从根目录开始处理
read_dir "$root_dir" "$2" 1
