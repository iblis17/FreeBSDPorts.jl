using BinDeps: LibraryDependency

import BinDeps: PackageManager
import BinDeps: pkg_name
import BinDeps: provides


type Ports <: PackageManager
    package::AbstractString
end


pkg_name(p::Ports) = p.package


doc"""
    provides{S<:AbstractString}(p::Type{Ports},
                                pkgs::Vector{S},
                                deps::Vector{LibraryDependency})
"""
function provides{S<:AbstractString}(p::Type{Ports},
                                     pkgs::Vector{S},
                                     deps::Vector{LibraryDependency};
                                     opts...)
    if length(pkgs) ≠ length(deps)
        error("length of pkgs and deps mismatch")
    end

    map(zip(pkgs, deps)) do pair
        provides(p, pair...; opts...)
    end
end
